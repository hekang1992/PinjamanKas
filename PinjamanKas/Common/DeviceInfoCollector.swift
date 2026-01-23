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

class DeviceInfoCollector {
    
    // MARK: - 公共方法
    func collectDeviceInfo(completion: @escaping ([String: Any]) -> Void) {
        var result: [String: Any] = [:]
        
        // 收集各种信息
        result["spilled"] = collectStorageInfo()
        result["weather"] = collectBatteryInfo()
        result["subordinates"] = collectDeviceInfo()
        result["lack"] = collectSecurityInfo()
        result["administrator"] = collectNetworkInfo()
        
        // 异步获取 WiFi 信息
        getWifiInfo { wifiInfo in
            result["apprenticeship"] = ["lampone": [wifiInfo]]
            completion(result)
        }
    }
    
    // MARK: - 存储信息
    private func collectStorageInfo() -> [String: String] {
        var storageInfo: [String: String] = [:]
        
        // 获取文件系统信息
        let fileManager = FileManager.default
        do {
            let systemAttributes = try fileManager.attributesOfFileSystem(forPath: NSHomeDirectory())
            
            if let totalSize = systemAttributes[.systemSize] as? NSNumber {
                storageInfo["heated"] = "\(totalSize.uint64Value)" // 手机存储内存总大小
            }
            
            if let freeSize = systemAttributes[.systemFreeSize] as? NSNumber {
                storageInfo["garage"] = "\(freeSize.uint64Value)" // 可用存储大小
            }
        } catch {
            storageInfo["heated"] = "0"
            storageInfo["garage"] = "0"
        }
        
        // 获取内存信息
        let memInfo = getMemoryInfo()
        storageInfo["donkeys"] = "\(memInfo.total)" // 内存大小
        storageInfo["grooming"] = "\(memInfo.free)" // 可用内存大小
        
        return storageInfo
    }
    
    private func getMemoryInfo() -> (total: UInt64, free: UInt64) {
        var totalMemory: UInt64 = 0
        var freeMemory: UInt64 = 0
        
        // 获取总内存
        let processInfo = ProcessInfo.processInfo
        totalMemory = processInfo.physicalMemory
        
        // 获取可用内存（近似值）
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
    
    // MARK: - 电池信息
    private func collectBatteryInfo() -> [String: Int] {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        var batteryInfo: [String: Int] = [:]
        
        // 电池百分比
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        batteryInfo["upholstery"] = batteryLevel
        
        // 是否正在充电
        let batteryState = UIDevice.current.batteryState
        let isCharging = (batteryState == .charging || batteryState == .full) ? 1 : 0
        batteryInfo["interfered"] = isCharging
        
        UIDevice.current.isBatteryMonitoringEnabled = false
        
        return batteryInfo
    }
    
    // MARK: - 设备信息
    private func collectDeviceInfo() -> [String: Any] {
        var deviceInfo: [String: Any] = [:]
        
        let device = UIDevice.current
        let screen = UIScreen.main
        
        // 系统版本
        deviceInfo["capable"] = device.systemVersion
        
        // 设备品牌
        deviceInfo["replacing"] = "iPhone"
        
        // 设备型号
        deviceInfo["alerted"] = getDeviceModel()
        
        // 设备高度和宽度（以像素为单位）
        let screenSize = screen.nativeBounds.size
        deviceInfo["laconic"] = Int(screenSize.height)
        deviceInfo["rush"] = Int(screenSize.width)
        
        // 物理尺寸（英寸）
        deviceInfo["errand"] = Device.current.diagonal
        
        return deviceInfo
    }
    
    private func getDeviceModel() -> String {
        let device = Device.current
        return device.description
    }
    
    // MARK: - 安全信息
    private func collectSecurityInfo() -> [String: Any] {
        var securityInfo: [String: Any] = [:]
        
        // 信号强度
        securityInfo["deserving"] = "0"
        
        // 是否是模拟器
        #if targetEnvironment(simulator)
            securityInfo["advanced"] = 1
        #else
            securityInfo["advanced"] = 0
        #endif
        
        // 是否越狱
        securityInfo["assist"] = isJailbroken() ? 1 : 0
        
        // 混淆字段
        securityInfo["personnel"] = 0
        
        return securityInfo
    }
    
    private func isJailbroken() -> Bool {
        // 检查常见越狱文件
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
        
        // 尝试写入系统目录
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
    
    // MARK: - 网络信息
    private func collectNetworkInfo() -> [String: Any] {
        var networkInfo: [String: Any] = [:]
        
        // 时区
        networkInfo["conscientious"] = TimeZone.current.abbreviation() ?? ""
        
        // 是否使用代理（简化判断）
        networkInfo["prices"] = 0
        
        // 是否使用 VPN（需要更复杂的检测）
        networkInfo["shooter"] = isVPNConnected() ? 1 : 0
        
        // 网络运营商
        networkInfo["stamps"] = ""
        
        // IDFV
        networkInfo["controlling"] = KeychainHelper.shared.getDeviceIDFV()
        
        // 设备语言
        networkInfo["employees"] = Locale.preferredLanguages.first ?? "en"
        
        // 网络类型
        networkInfo["incapacitated"] = UserDefaults.standard.object(forKey: "network_type") ?? ""
        
        // 是否是手机
        networkInfo["partially"] = Device.current.isPhone ? "1" : "0"
        
        // IP地址（获取本地IP）
        networkInfo["shortage"] = getLocalIPAddress() ?? ""
        
        // IDFA（需要用户授权）
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
    
    // MARK: - WiFi信息（异步获取）
    private func getWifiInfo(completion: @escaping ([String: String]) -> Void) {
        var wifiInfo: [String: String] = [:]
        
        if #available(iOS 14.0, *) {
            if let interfaces = CNCopySupportedInterfaces() as? [String] {
                for interface in interfaces {
                    if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? {
                        wifiInfo["rocco"] = interfaceInfo[kCNNetworkInfoKeyBSSID as String] as? String ?? ""
                        wifiInfo["runner"] = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String ?? ""
                        wifiInfo["shylocks"] = wifiInfo["rocco"]
                        wifiInfo["steering"] = wifiInfo["runner"]
                        wifiInfo["accounts"] = "0"
                        completion(wifiInfo)
                        return
                    }
                }
            }
        } else {
            
        }
        
        completion(wifiInfo)
    }
}
