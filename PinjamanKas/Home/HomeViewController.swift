//
//  HomeViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire
import MJRefresh

class HomeViewController: BaseViewController {
    
    lazy var homeView: HomeView = {
        let homeView = HomeView()
        return homeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.homeInfo()
            }
        })
        
        homeView.clickBlock = { [weak self] productID in
            guard let self = self else { return }
            if !UserManager.shared.isLogin {
                let navc = BaseNavigationController(rootViewController: LoginViewController())
                navc.modalPresentationStyle = .overFullScreen
                self.present(navc, animated: true)
                return
            }
            if homeView.mentView.sureBtn.isSelected == false {
                ToastManager.showMessage(languageCode == "701" ? "Harap konfirmasi perjanjian pinjaman terlebih dahulu." : "Please confirm the loan agreement first.")
                return
            }
            Task {
                await self.clickProductInfo(with: productID)
            }
            
        }
        
        Task {
            await self.getCitysInfo()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.homeInfo()
        }
    }
    
}

extension HomeViewController {
    
    private func homeInfo() async {
        do {
            LoadingView.shared.show()
            let model: BaseModel = try await NetworkManager.shared.request("/softly/great/family/sonny", method: .get)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                let magicallyModelArray = model.sagged?.magically ?? []
                if let listModel = magicallyModelArray.first(where: { $0.appear == "wedding2" }) {
                    self.homeView.listModel = listModel.lighter?.first ?? lighterModel()
                }
            }
            LoadingView.shared.hide()
            await MainActor.run {
                self.homeView.scrollView.mj_header?.endRefreshing()
            }
        } catch {
            LoadingView.shared.hide()
            await MainActor.run {
                self.homeView.scrollView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func clickProductInfo(with productID: String) async {
        do {
            LoadingView.shared.show()
            let params = ["barely": "1001",
                          "swayed": String(Int(900 + 100)),
                          "pretended": "1000",
                          "rival": productID,
                          "infatuated": String(Int(100 + 200))]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/would/preferred/concealed", method: .post, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                let pageUrl = model.sagged?.busied ?? ""
                if pageUrl.isEmpty {
                    return
                }
                if pageUrl.hasPrefix(DeepLinkRoute.scheme_url) {
                    URLSchemeRouter.handle(pageURL: pageUrl, from: self)
                }else if pageUrl.hasPrefix("http") {
                    self.pushWebVc(with: pageUrl)
                }
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
    private func getCitysInfo() async {
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/softly/fortyeight/threats/checking", method: .get)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                CitysModel.shared.modelArray = model.sagged?.magically ?? []
            }
        } catch {
            
        }
    }
    
}
