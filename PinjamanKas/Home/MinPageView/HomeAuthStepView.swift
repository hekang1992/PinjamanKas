//
//  HomeAuthStepView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/2/2.
//

import UIKit
import SnapKit

class HomeAuthStepView: UIView {
    
    var type: String? {
        didSet {
            guard let type = type else { return }
            updateProgress(type: type)
        }
    }
    
    private let dashLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor(hex: "#E8FA00")?.cgColor
        layer.lineWidth = 8
        layer.lineDashPattern = [2, 2]
        layer.fillColor = nil
        return layer
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hex: "#F1F1F3")
        return view
    }()
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.text = "Informasi yang sempurna"
        label.textColor = UIColor(hex: "#9D9D9F")
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Dapatkan kuota"
        label.textColor = UIColor(hex: "#9D9D9F")
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#333333")
        label.font = .systemFont(ofSize: 10)
        label.layer.cornerRadius = 13
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.backgroundColor = UIColor(hex: "#CDF300")
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgView)
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(lineView)
        addSubview(nameLabel)
        
        lineView.layer.addSublayer(dashLayer)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(8)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.left.equalToSuperview().offset(0)
            make.size.equalTo(CGSize(width: 62, height: 26))
        }
        
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalTo(bgView)
            make.right.equalTo(nameLabel.snp.centerX)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = CGMutablePath()
        path.addLines(between: [
            CGPoint(x: 0, y: lineView.bounds.midY),
            CGPoint(x: lineView.bounds.width, y: lineView.bounds.midY)
        ])
        dashLayer.path = path
        dashLayer.frame = lineView.bounds
    }
    
    private func updateProgress(type: String) {
        let width = self.frame.width > 0 ? self.frame.width : 327
        var offset: CGFloat = 0
        
        switch type {
        case "extreme1":
            nameLabel.text = "0%\ntersisa"
            offset = 0
        case "extreme3":
            nameLabel.text = "25%\ntersisa"
            offset = width * 0.25 - 31
        case "extreme4":
            nameLabel.text = "50%\ntersisa"
            offset = width * 0.5 - 31
        case "extreme5":
            nameLabel.text = "75%\ntersisa"
            offset = width * 0.75 - 31
        case "":
            nameLabel.text = "100%\ntersisa"
            offset = width - 62
        default:
            break
        }
        
        nameLabel.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(max(0, offset))
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
