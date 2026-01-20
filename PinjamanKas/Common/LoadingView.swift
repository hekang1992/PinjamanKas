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

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexString).scanHexInt64(&rgb) else {
            return nil
        }
        
        let length = hexString.count
        
        switch length {
        case 6: // RRGGBB
            self.init(
                red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgb & 0x0000FF) / 255.0,
                alpha: alpha
            )
        case 8: // AARRGGBB
            self.init(
                red: CGFloat((rgb & 0x00FF0000) >> 16) / 255.0,
                green: CGFloat((rgb & 0x0000FF00) >> 8) / 255.0,
                blue: CGFloat(rgb & 0x000000FF) / 255.0,
                alpha: CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            )
        default:
            return nil
        }
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }
    
    var hexString: String? {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        
        var hexString = "#"
        hexString += String(format: "%02X", r)
        hexString += String(format: "%02X", g)
        hexString += String(format: "%02X", b)
        
        return hexString
    }
}
