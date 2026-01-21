//
//  ProductViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import SnapKit
import Alamofire
import MJRefresh

class ProductViewController: BaseViewController {
    
    var productID: String = ""
    
    var model: BaseModel?
    
    lazy var productView: ProductView = {
        let productView = ProductView(frame: .zero)
        return productView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(productView)
        productView.snp.makeConstraints { make in
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
        
        productView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.detailInfo()
            }
        })
        
        productView.nextBlock = { [weak self] in
            guard let self = self, let model = model else { return }
            let nextModel = model.sagged?.earth ?? flingingModel()
            self.tapClickInfo(with: nextModel)
        }
        
        productView.tapListBlock = { [weak self] model in
            guard let self = self else { return }
            let cronies = model.cronies ?? 0
            if cronies == 0 {
                productView.nextBlock?()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.detailInfo()
        }
    }
    
}

extension ProductViewController {
    
    private func tapClickInfo(with model: flingingModel) {
        let interior = model.interior ?? ""
        switch interior {
        case "extreme1":
            let frontVc = FrontViewController()
            frontVc.params = ["title": model.uptown ?? "", "productID": productID]
            self.navigationController?.pushViewController(frontVc, animated: true)
            break
        case "extreme2":
            break
        case "extreme3":
            break
        case "extreme4":
            break
        case "extreme5":
            break
        default:
            break
        }
    }
    
}

extension ProductViewController {
    
    private func detailInfo() async {
        do {
            LoadingView.shared.show()
            let params = ["rival": productID, "frequenting": String(Int(2 + 2))]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/angry/corleone/fontane", method: .post, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                self.model = model
                let listModel = model.sagged?.retainer
                self.appHeadView.nameLabel.text = listModel?.rats ?? ""
                self.productView.applyBtn.setTitle(listModel?.soltozzo ?? "", for: .normal)
                self.productView.modelArray = model.sagged?.flinging ?? []
                self.productView.model = listModel
            }
            LoadingView.shared.hide()
            await self.productView.scrollView.mj_header?.endRefreshing()
        } catch {
            LoadingView.shared.hide()
            await self.productView.scrollView.mj_header?.endRefreshing()
        }
    }
    
}
