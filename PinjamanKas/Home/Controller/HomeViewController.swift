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
import FBSDKCoreKit

class HomeViewController: BaseViewController {
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.isHidden = true
        return view
    }()
    
    private lazy var mainPageView: HomeMainPageView = {
        let view = HomeMainPageView()
        view.isHidden = true
        return view
    }()
    
    private let locationManager = LocationManager()
    
    private let deviceInfoCollector = DeviceInfoCollector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefresh()
        setupCallbacks()
        loadInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataOnAppear()
        getLocationInfo()
    }
}

extension HomeViewController {
    private func setupUI() {
        view.addSubview(homeView)
        view.addSubview(mainPageView)
        
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainPageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupRefresh() {
        homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.homeInfo()
            }
        })
        
        mainPageView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.homeInfo()
            }
        })
    }
    
    private func setupCallbacks() {
        homeView.clickBlock = { [weak self] productID in
            guard let self = self else { return }
            self.handleProductClick(productID)
        }
        
        mainPageView.cellTapBlock = { [weak self] model in
            guard let self = self else { return }
            let productID = String(Int(model.holes ?? 0))
            self.handleProductClick(productID)
        }
    }
    
    private func loadInitialData() {
        Task {
            await self.getCitysInfo()
        }
    }
    
    private func loadDataOnAppear() {
        Task {
            async let fetchHomeInfo: Void = homeInfo()
            async let uploadIDFATask: Void = uploadIDFA()
            _ = await (fetchHomeInfo, uploadIDFATask)
        }
    }
}

// MARK: - Action Handlers
extension HomeViewController {
    
    private func handleProductClick(_ productID: String) {
        guard UserManager.shared.isLogin else {
            showLoginViewController()
            return
        }
        
        guard homeView.mentView.sureBtn.isSelected else {
            let message = languageCode == "701" ?
            "Harap konfirmasi perjanjian pinjaman terlebih dahulu." :
            "Please confirm the loan agreement first."
            ToastManager.showMessage(message)
            return
        }
        
        Task {
            await self.clickProductInfo(with: productID)
        }
    }
    
    private func showLoginViewController() {
        let navc = BaseNavigationController(rootViewController: LoginViewController())
        navc.modalPresentationStyle = .overFullScreen
        self.present(navc, animated: true)
    }
    
    private func getLocationInfo() {
        locationManager.fetchLocationInfo { [weak self] locationInfo in
            guard let self = self, let locationInfo = locationInfo else {
                Task {
                    await self?.uploadDeviceInfo()
                }
                return
            }
            Task {
                async let _: Void = self.uploadLocation(with: locationInfo)
                async let _: Void = self.uploadDeviceInfo()
            }
        }
    }
    
    private func uploadDeviceInfo() async {
        
        deviceInfoCollector.collectDeviceInfo { deviceInfo in
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: deviceInfo, options: [])
                let base64String = jsonData.base64EncodedString()
                
                Task {
                    do {
                        let params = ["sagged": base64String]
                        let _: BaseModel = try await NetworkManager.shared.request("/softly/after/pearl/respect", method: .post, params: params)
                    } catch {
                        
                    }
                }
                
            } catch {
                
            }
        }
    }
    
    
}

// MARK: - Network Methods
extension HomeViewController {
    
    private func uploadLocation(with params: [String: String]) async {
        do {
            let _: BaseModel = try await NetworkManager.shared.request("/softly/appeared/saidhe/hastilythey", method: .post, params: params)
        } catch {
            
        }
    }
    
    
    private func homeInfo() async {
        do {
            LoadingView.shared.show()
            let model: BaseModel = try await NetworkManager.shared.request(
                "/softly/great/family/sonny",
                method: .get
            )
            
            handleHomeInfoResponse(model)
            
            LoadingView.shared.hide()
            endRefreshing()
        } catch {
            handleHomeInfoError(error)
        }
    }
    
    @MainActor
    private func handleHomeInfoResponse(_ model: BaseModel) {
        guard let sinking = model.sinking, ["0", "00"].contains(sinking) else {
            hideAllViews()
            return
        }
        
        guard let magicallyModelArray = model.sagged?.magically else {
            hideAllViews()
            return
        }
        
        if let listModel = magicallyModelArray.first(where: { $0.appear == "wedding2" }) {
            showHomeView(with: listModel)
        } else if magicallyModelArray.contains(where: { $0.appear == "wedding3" }) {
            var finalModels = magicallyModelArray
            if magicallyModelArray.contains(where: { $0.appear == "wedding1" }) {
                finalModels = magicallyModelArray.filter { $0.appear != "wedding1" }
            }
            showMainPageView(with: finalModels)
        } else {
            hideAllViews()
        }
    }
    
    @MainActor
    private func handleHomeInfoError(_ error: Error) {
        hideAllViews()
        LoadingView.shared.hide()
        homeView.scrollView.mj_header?.endRefreshing()
    }
    
    private func clickProductInfo(with productID: String) async {
        do {
            LoadingView.shared.show()
            
            let params = [
                "barely": "1001",
                "swayed": String(Int(900 + 100)),
                "pretended": "1000",
                "rival": productID,
                "infatuated": String(Int(100 + 200))
            ]
            
            let model: BaseModel = try await NetworkManager.shared.request(
                "/softly/would/preferred/concealed",
                method: .post,
                params: params
            )
            
            handleProductInfoResponse(model)
            LoadingView.shared.hide()
            
        } catch {
            LoadingView.shared.hide()
        }
    }
    
    @MainActor
    private func handleProductInfoResponse(_ model: BaseModel) {
        guard let sinking = model.sinking, ["0", "00"].contains(sinking),
              let pageUrl = model.sagged?.busied, !pageUrl.isEmpty else {
            return
        }
        
        if pageUrl.hasPrefix(DeepLinkRoute.scheme_url) {
            URLSchemeRouter.handle(pageURL: pageUrl, from: self)
        } else if pageUrl.hasPrefix("http") {
            self.pushWebVc(with: pageUrl)
        }
    }
    
    private func getCitysInfo() async {
        do {
            let model: BaseModel = try await NetworkManager.shared.request(
                "/softly/fortyeight/threats/checking",
                method: .get
            )
            
            if let sinking = model.sinking, ["0", "00"].contains(sinking) {
                CitysModel.shared.modelArray = model.sagged?.magically ?? []
            }
        } catch {
            
        }
    }
    
    private func uploadIDFA() async {
        let idfa = KeychainHelper.shared.getIDFA()
        let idfv = KeychainHelper.shared.getDeviceIDFV()
        let params = ["controlling": idfv, "africa": idfa]
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request(
                "/softly/contrition/witnesses/hospital",
                method: .post,
                params: params
            )
            
            if let sinking = model.sinking, ["0", "00"].contains(sinking),
               let fcModel = model.sagged?.facebook {
                configureFacebookSDK(with: fcModel)
            }
        } catch {
            
        }
    }
}

// MARK: - UI State Management
extension HomeViewController {
    @MainActor
    private func showHomeView(with listModel: magicallyModel) {
        homeView.isHidden = false
        mainPageView.isHidden = true
        homeView.listModel = listModel.lighter?.first ?? lighterModel()
    }
    
    @MainActor
    private func showMainPageView(with modelArray: [magicallyModel]) {
        homeView.isHidden = true
        mainPageView.isHidden = false
        mainPageView.modelArray = modelArray
    }
    
    @MainActor
    private func hideAllViews() {
        homeView.isHidden = true
        mainPageView.isHidden = true
    }
    
    @MainActor
    private func endRefreshing() {
        homeView.scrollView.mj_header?.endRefreshing()
        mainPageView.tableView.mj_header?.endRefreshing()
    }
}

extension HomeViewController {
    private func configureFacebookSDK(with model: facebookModel) {
        Settings.shared.displayName = model.displayName ?? ""
        Settings.shared.appURLSchemeSuffix = model.appURLSchemeSuffix ?? ""
        Settings.shared.appID = model.appID ?? ""
        Settings.shared.clientToken = model.clientToken ?? ""
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
    }
}
