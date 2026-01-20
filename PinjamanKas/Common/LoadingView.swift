//
//  LoadingView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class LoadingView {
    
    static let shared = LoadingView()
    private init() {}
    
    private var containerView: UIView?
    private var backgroundView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    func show() {
        if containerView != nil {
            return
        }
        
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        window.addSubview(backgroundView!)
        
        backgroundView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView = UIView()
        containerView?.backgroundColor = .white
        containerView?.layer.cornerRadius = 12
        containerView?.clipsToBounds = true
        backgroundView?.addSubview(containerView!)
        
        containerView?.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.color = .darkGray
        containerView?.addSubview(activityIndicator!)
        
        activityIndicator?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        activityIndicator?.startAnimating()
    }
    
    func hide() {
        activityIndicator?.stopAnimating()
        containerView?.removeFromSuperview()
        backgroundView?.removeFromSuperview()
        containerView = nil
        backgroundView = nil
        activityIndicator = nil
    }
    
}
