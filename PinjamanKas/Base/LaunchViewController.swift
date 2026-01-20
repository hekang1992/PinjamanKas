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
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        Task {
            await self.initInfo()
        }
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


