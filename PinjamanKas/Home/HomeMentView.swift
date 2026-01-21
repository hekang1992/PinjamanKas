//
//  HomeMentView.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit

class HomeMentView: BaseView {
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.isSelected = true
        sureBtn.setImage(UIImage(named: "sure_nor_image"), for: .normal)
        sureBtn.setImage(UIImage(named: "sure_sel_image"), for: .selected)
        sureBtn.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        return sureBtn
    }()
    
    private lazy var loanLabel: UILabel = {
        
        let fullText = languageCode == "701" ? "Harap baca <Syarat dan Ketentuan Pinjaman> dengan saksama untuk pengalaman meminjam yang nyaman." : "Please read the <Loan terms> carefully for a worry-free borrowing experience."
        let targetText = languageCode == "701" ? "<Syarat dan Ketentuan Pinjaman>" : "<Loan terms>"
        
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = true
        label.textColor = UIColor.init(hex: "#9D9D9F")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let range = (fullText as NSString).range(of: targetText)
        
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .medium), range: range)
        }
        
        label.attributedText = attributedString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTextTap(_:)))
        label.addGestureRecognizer(tapGesture)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sureBtn)
        addSubview(loanLabel)
        sureBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(14)
        }
        loanLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(sureBtn.snp.right).offset(8)
            make.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeMentView {
    
    @objc private func handleTextTap(_ gesture: UITapGestureRecognizer) {
        ToastManager.showMessage("协议====")
    }
    
    @objc private func sureClick() {
        sureBtn.isSelected.toggle()
    }
}
