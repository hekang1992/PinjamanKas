//
//  H5WebViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import WebKit
import SnapKit

class H5WebViewController: BaseViewController {
    
    var pageUrl: String = ""
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebPage()
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    private func setupUI() {
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
        
        let requestUrl = URLParameterBuilder.appendParams(to: "https://www.baidu.com")
        
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
        // 根据不同的方法名处理H5调用
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
            print("未处理的方法: \(message.name)")
        }
    }
    
    // MARK: - H5方法处理实现
    private func handleHarmonyGrove(message: WKScriptMessage) {
        print("调用 harmonyGrove 方法")
        // 这里实现 harmonyGrove 的逻辑
        // message.body 包含H5传递过来的参数
    }
    
    private func handleWhisperedSecrets(message: WKScriptMessage) {
        print("调用 whisperedSecrets 方法")
        // 这里实现 whisperedSecrets 的逻辑
    }
    
    private func handleFrostyMorn(message: WKScriptMessage) {
        print("调用 frostyMorn 方法")
        // 这里实现 frostyMorn 的逻辑
    }
    
    private func handleGalaxyWaltz(message: WKScriptMessage) {
        print("调用 galaxyWaltz 方法")
        // 这里实现 galaxyWaltz 的逻辑
    }
    
    private func handleIllusionMirage(message: WKScriptMessage) {
        print("调用 illusionMirage 方法")
        // 这里实现 illusionMirage 的逻辑
    }
    
    private func handleJadeEmbrace(message: WKScriptMessage) {
        print("调用 jadeEmbrace 方法")
        // 这里实现 jadeEmbrace 的逻辑
    }
}
