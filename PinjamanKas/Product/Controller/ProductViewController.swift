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
            }else {
                tapClickInfo(with: model)
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
        let orderID = self.model?.sagged?.retainer?.shipment ?? ""
        switch interior {
        case "extreme1":
            Task {
                await self.frontInfo(with: model)
            }
            break
            
        case "extreme2":
            break
            
        case "extreme3":
            let personalVc = PersonalViewController()
            personalVc.params = ["title": model.uptown ?? "",
                                 "productID": productID,
                                 "orderID": orderID]
            self.navigationController?.pushViewController(personalVc, animated: true)
            
        case "extreme4":
            let contactVc = ContactViewController()
            contactVc.params = ["title": model.uptown ?? "",
                                "productID": productID,
                                "orderID": orderID]
            self.navigationController?.pushViewController(contactVc, animated: true)
            
        case "extreme5":
            let walletVc = WalletViewController()
            walletVc.params = ["title": model.uptown ?? "",
                               "productID": productID,
                               "orderID": orderID]
            self.navigationController?.pushViewController(walletVc, animated: true)
            
        default:
            break
        }
    }
    
    private func frontInfo(with listModel: flingingModel) async {
        do {
            LoadingView.shared.show()
            let params = ["rival": productID,
                          "road": "1"]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/fiveyear/during/never", method: .get, params: params)
            let sinking = model.sinking ?? ""
            if ["0", "00"].contains(sinking) {
                let front = model.sagged?.vera?.cronies ?? 0
                let face = model.sagged?.park?.cronies ?? 0
                if front == 0 {
                    let frontVc = FrontViewController()
                    frontVc.params = ["title": listModel.uptown ?? "",
                                      "productID": productID,
                                      "orderID": self.model?.sagged?.retainer?.shipment ?? ""]
                    self.navigationController?.pushViewController(frontVc, animated: true)
                    return
                }
                
                if face == 0 {
                    let faceVc = FaceViewController()
                    faceVc.params = ["title": listModel.uptown ?? "",
                                     "productID": productID,
                                     "orderID": self.model?.sagged?.retainer?.shipment ?? ""]
                    self.navigationController?.pushViewController(faceVc, animated: true)
                    return
                }
                
                if face == 1 && front == 1 {
                    let completeVc = CompleteViewController()
                    completeVc.params = ["title": listModel.uptown ?? "",
                                         "productID": productID,
                                         "orderID": self.model?.sagged?.retainer?.shipment ?? ""]
                    self.navigationController?.pushViewController(completeVc, animated: true)
                    return
                }
                
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
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
