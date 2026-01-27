//
//  DeviceInfoCollector.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/23.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import CoreTelephony
import AdSupport
import UIKit
import DeviceKit
import NetworkExtension

class DeviceInfoCollector {
    
    func collectDeviceInfo(completion: @escaping ([String: Any]) -> Void) {
        var result: [String: Any] = [:]
        
        result["spilled"] = collectStorageInfo()
        result["weather"] = collectBatteryInfo()
        result["subordinates"] = collectDeviceInfo()
        result["lack"] = collectSecurityInfo()
        result["administrator"] = collectNetworkInfo()
        
        getWifiInfo { wifiInfo in
            result["apprenticeship"] = ["lampone": [wifiInfo]]
            completion(result)
        }
    }
    
    private func collectStorageInfo() -> [String: String] {
        var storageInfo: [String: String] = [:]
        
        let fileManager = FileManager.default
        do {
            let systemAttributes = try fileManager.attributesOfFileSystem(forPath: NSHomeDirectory())
            
            if let totalSize = systemAttributes[.systemSize] as? NSNumber {
                storageInfo["heated"] = "\(totalSize.uint64Value)"
            }
            
            if let freeSize = systemAttributes[.systemFreeSize] as? NSNumber {
                storageInfo["garage"] = "\(freeSize.uint64Value)"
            }
        } catch {
            storageInfo["heated"] = "0"
            storageInfo["garage"] = "0"
        }
        
        let memInfo = getMemoryInfo()
        storageInfo["donkeys"] = "\(memInfo.total)"
        storageInfo["grooming"] = "\(memInfo.free)"
        
        return storageInfo
    }
    
    private func getMemoryInfo() -> (total: UInt64, free: UInt64) {
        var totalMemory: UInt64 = 0
        var freeMemory: UInt64 = 0
        
        let processInfo = ProcessInfo.processInfo
        totalMemory = processInfo.physicalMemory
        
        var stats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64>.size / MemoryLayout<integer_t>.size)
        
        let hostPort = mach_host_self()
        let result = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(hostPort, HOST_VM_INFO64, $0, &count)
            }
        }
        
        if result == KERN_SUCCESS {
            let pageSize = vm_kernel_page_size
            freeMemory = UInt64(stats.free_count) * UInt64(pageSize)
        }
        
        return (totalMemory, freeMemory)
    }
    
    private func collectBatteryInfo() -> [String: Int] {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        var batteryInfo: [String: Int] = [:]
        
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        batteryInfo["upholstery"] = batteryLevel
        
        let batteryState = UIDevice.current.batteryState
        let isCharging = (batteryState == .charging || batteryState == .full) ? 1 : 0
        batteryInfo["interfered"] = isCharging
        
        UIDevice.current.isBatteryMonitoringEnabled = false
        
        return batteryInfo
    }
    
    private func collectDeviceInfo() -> [String: Any] {
        var deviceInfo: [String: Any] = [:]
        
        let device = UIDevice.current
//        let screen = UIScreen.main
        
        deviceInfo["capable"] = device.systemVersion
        
        deviceInfo["replacing"] = "iPhone"
        
        deviceInfo["alerted"] = getDeviceModel()
        
        deviceInfo["magazine"] = Device.identifier
        
        deviceInfo["laconic"] = Int(UIScreen.main.bounds.size.height)
        deviceInfo["rush"] = Int(UIScreen.main.bounds.size.width)
        
        deviceInfo["errand"] = String(Device.current.diagonal)
        
        return deviceInfo
    }
    
    private func getDeviceModel() -> String {
        let device = Device.current
        return device.description
    }
    
    private func collectSecurityInfo() -> [String: Any] {
        var securityInfo: [String: Any] = [:]
        
        securityInfo["deserving"] = "0"
        
#if targetEnvironment(simulator)
        securityInfo["advanced"] = 1
#else
        securityInfo["advanced"] = 0
#endif
        
        securityInfo["assist"] = isJailbroken() ? 1 : 0
        
        securityInfo["personnel"] = 0
        
        return securityInfo
    }
    
    private func isJailbroken() -> Bool {
        let jailbreakFilePaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/"
        ]
        
        for path in jailbreakFilePaths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        let stringToWrite = "Jailbreak Test"
        do {
            try stringToWrite.write(toFile: "/private/JailbreakTest.txt",
                                    atomically: true,
                                    encoding: .utf8)
            return true
        } catch {
            return false
        }
    }
    
    private func collectNetworkInfo() -> [String: Any] {
        var networkInfo: [String: Any] = [:]
        
        networkInfo["conscientious"] = TimeZone.current.abbreviation() ?? ""
        
        networkInfo["prices"] = isUsingProxy() ? 1 : 0
        
        networkInfo["shooter"] = isVPNConnected() ? 1 : 0
        
        networkInfo["stamps"] = ""
        
        networkInfo["controlling"] = KeychainHelper.shared.getDeviceIDFV()
        
        networkInfo["employees"] = Locale.preferredLanguages.first ?? "en"
        
        networkInfo["incapacitated"] = UserDefaults.standard.object(forKey: "network_type") ?? ""
        
        networkInfo["partially"] = Device.current.isPhone ? "1" : "0"
        
        networkInfo["shortage"] = getLocalIPAddress() ?? ""
        
        networkInfo["africa"] = KeychainHelper.shared.getIDFA()
        
        return networkInfo
    }
    
    private func isVPNConnected() -> Bool {
        let cfDict = CFNetworkCopySystemProxySettings()
        let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        let keys = nsDict["__SCOPED__"] as? NSDictionary
        
        for key: String in keys?.allKeys as? [String] ?? [] {
            if key.contains("tap") || key.contains("tun") ||
                key.contains("ppp") || key.contains("ipsec") ||
                key.contains("utun") {
                return true
            }
        }
        return false
    }
    
    private func isUsingProxy() -> Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
            return false
        }
        
        if let httpProxy = proxySettings["HTTPProxy"] as? String, !httpProxy.isEmpty {
            return true
        }
        
        if let httpsProxy = proxySettings["HTTPSProxy"] as? String, !httpsProxy.isEmpty {
            return true
        }
        
        if let proxyEnable = proxySettings["HTTPEnable"] as? Int, proxyEnable == 1 {
            return true
        }
        
        return false
    }
    
    private func getLocalIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    let name = String(cString: (interface?.ifa_name)!)
                    
                    if name == "en0" || name == "en2" || name == "en3" || name == "en4" || name.hasPrefix("en") {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr,
                                    socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname,
                                    socklen_t(hostname.count),
                                    nil,
                                    socklen_t(0),
                                    NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    private func getWifiInfo(completion: @escaping ([String: String]) -> Void) {
        var wifiInfo: [String: String] = [:]
        NEHotspotNetwork.fetchCurrent { hotspotNetwork in
            guard let network = hotspotNetwork else {
                completion(wifiInfo)
                return
            }
            wifiInfo["rocco"] = network.bssid
            wifiInfo["runner"] = network.ssid
            wifiInfo["shylocks"] = wifiInfo["rocco"]
            wifiInfo["steering"] = wifiInfo["runner"]
            completion(wifiInfo)
        }
        
    }
    
}
