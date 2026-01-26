//
//  H5WebViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import WebKit
import SnapKit
import StoreKit

class H5WebViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    private let locationManager = LocationManager()
    
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        let methods = ["harmonyGrove", "whisperedSecrets", "frostyMorn",
                       "galaxyWaltz", "illusionMirage", "jadeEmbrace"]
        methods.forEach { method in
            contentController.add(self, name: method)
        }
        
        config.userContentController = contentController
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .clear
        progressView.progressTintColor = UIColor.systemBlue
        progressView.isHidden = true
        return progressView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "ce_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebPage()
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    private func setupUI() {
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(appHeadView)
        appHeadView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(appHeadView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        
    }
    
    private func loadWebPage() {
        
        let requestUrl = URLParameterBuilder.appendParams(to: pageUrl)
        
        guard let url = URL(string: requestUrl) else {
            return
        }
        
        print("requestUrl======\(requestUrl)")
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            let progress = Float(webView.estimatedProgress)
            progressView.progress = progress
            
            if progress == 1.0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.progressView.alpha = 0
                }) { _ in
                    self.progressView.isHidden = true
                    self.progressView.progress = 0
                }
            } else if progressView.isHidden {
                progressView.isHidden = false
                progressView.alpha = 1
            }
        } else if keyPath == "title" {
            if let title = webView.title, !title.isEmpty {
                appHeadView.nameLabel.text = title
            }
        }
    }
    
}

extension H5WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        print("name===\(message.name)")
        print("body===\(message.body)")
        switch message.name {
        case "harmonyGrove":
            handleHarmonyGrove(message: message)
            
        case "whisperedSecrets":
            handleWhisperedSecrets(message: message)
            
        case "frostyMorn":
            handleFrostyMorn(message: message)
            
        case "galaxyWaltz":
            handleGalaxyWaltz(message: message)
            
        case "illusionMirage":
            handleIllusionMirage(message: message)
            
        case "jadeEmbrace":
            handleJadeEmbrace(message: message)
            
        default:
            break
        }
    }
    
    private func handleHarmonyGrove(message: WKScriptMessage) {
        locationManager.fetchLocationInfo { locationInfo in }
        let body = message.body as? [String] ?? []
        let productID = body.first ?? ""
        let orderID = body.last ?? ""
        Task{
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            let params = ["bladder": productID,
                          "hinted": "9",
                          "shipment": orderID,
                          "brute": String(Int(Date().timeIntervalSince1970)),
                          "brawny": String(Int(Date().timeIntervalSince1970))]
            await self.softlySmallInfo(with: params)
        }
    }
    
    private func handleWhisperedSecrets(message: WKScriptMessage) {
        let body = message.body as? String ?? ""
        if body.hasPrefix(DeepLinkRoute.scheme_url) {
            URLSchemeRouter.handle(pageURL: body, from: self)
        }else if body.hasPrefix("http") {
            self.pageUrl = body
            self.loadWebPage()
        }
    }
    
    private func handleFrostyMorn(message: WKScriptMessage) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func handleGalaxyWaltz(message: WKScriptMessage) {
        NotificationCenter.default.post(name: Notification.Name("changeRootVc"), object: nil)
    }
    
    private func handleIllusionMirage(message: WKScriptMessage) {
        let email = message.body as? String ?? ""
        let phone = UserManager.shared.getPhone()
        let body = "Pinjaman Kas: \(phone)"
        
        guard let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let emailURL = URL(string: "mailto:\(email)?body=\(encodedBody)"),
              UIApplication.shared.canOpenURL(emailURL) else {
            return
        }
        UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
    }
    
    private func handleJadeEmbrace(message: WKScriptMessage) {
        DispatchQueue.main.async {
            self.toAppStore()
        }
    }
}

extension H5WebViewController {
    
    func toAppStore() {
        guard #available(iOS 14.0, *),
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        SKStoreReviewController.requestReview(in: windowScene)
    }
    
}
