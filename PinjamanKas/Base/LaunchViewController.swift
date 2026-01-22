//
//  LaunchViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire

class LaunchViewController: BaseViewController {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        NetworkMonitor.shared.statusChanged = { status in
            switch status {
            case .notReachable:
                UserDefaults.standard.set("Bad Network", forKey: "network_type")
                print("Bad Network=====")
                
            case .reachable(.ethernetOrWiFi):
                UserDefaults.standard.set("WIFI", forKey: "network_type")
                print("WIFI=====")
                NetworkMonitor.shared.stopListening()
                Task {
                    await self.initInfo()
                }
                
            case .reachable(.cellular):
                UserDefaults.standard.set("5G", forKey: "network_type")
                print("5G=====")
                NetworkMonitor.shared.stopListening()
                Task {
                    await self.initInfo()
                }
                
            case .unknown:
                UserDefaults.standard.set("Unknown Network", forKey: "network_type")
                print("Unknown Network=====")
            }
        }

        NetworkMonitor.shared.startListening()
        
    }
    
}

extension LaunchViewController {
    
    private func initInfo() async {
        do {
            LoadingView.shared.show()
            let model: BaseModel = try await NetworkManager.shared.request("/softly/terror/slacks/another", method: .post)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                let petes = model.sagged?.petes ?? ""
                LanguageManager.shared.saveLanguageInfo(petes: petes)
                NotificationCenter.default.post(name: Notification.Name("changeRootVc"), object: nil)
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
}


