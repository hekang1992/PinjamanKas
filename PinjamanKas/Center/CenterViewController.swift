//
//  CenterViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import MJRefresh
import Alamofire

class CenterViewController: BaseViewController {
    
    lazy var centerView: CenterView = {
        let centerView = CenterView(frame: .zero)
        return centerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        centerView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.centerInfo()
            }
        })
        
        centerView.cellBlock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.strange ?? ""
            if pageUrl.isEmpty {
                return
            }
            if pageUrl.hasPrefix(DeepLinkRoute.scheme_url) {
                URLSchemeRouter.handle(pageURL: pageUrl, from: self)
            }else if pageUrl.hasPrefix("http") {
                self.pushWebVc(with: pageUrl)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.centerInfo()
        }
    }
    
}

extension CenterViewController {
    
    private func centerInfo() async {
        do {
            LoadingView.shared.show()
            let model: BaseModel = try await NetworkManager.shared.request("/softly/exemption/magazine/godson", method: .get)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                self.centerView.modelArray = model.sagged?.tail ?? []
                self.centerView.tableView.reloadData()
            }else {
                ToastManager.showMessage(model.strangler ?? "")
            }
            LoadingView.shared.hide()
            await MainActor.run {
                self.centerView.scrollView.mj_header?.endRefreshing()
            }
        } catch {
            LoadingView.shared.hide()
            await MainActor.run {
                self.centerView.scrollView.mj_header?.endRefreshing()
            }
        }
    }
    
}
