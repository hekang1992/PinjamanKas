//
//  BaseViewController.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController {
    
    let languageCode = LanguageManager.shared.getLanguage()
    
    lazy var appHeadView: AppHeadView = {
        let appHeadView = AppHeadView(frame: .zero)
        return appHeadView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

extension BaseViewController {
    
    func pushWebVc(with pageUrl: String) {
        let webVc = H5WebViewController()
        webVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(webVc, animated: true)
    }
    
    func toProductDetailVc() {
        guard let nav = navigationController,
              let productVC = nav.viewControllers.first(where: { $0 is ProductViewController })
        else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        nav.popToViewController(productVC, animated: true)
    }
    
    func nextDetailInfo(with productID: String) async {
        do {
            LoadingView.shared.show()
            let params = ["rival": productID, "frequenting": String(Int(2 + 2))]
            let model: BaseModel = try await NetworkManager.shared.request("/softly/angry/corleone/fontane", method: .post, params: params)
            let sinking = model.sinking ?? ""
            let orderID = model.sagged?.retainer?.shipment ?? ""
            if ["0", "00"].contains(sinking) {
                let type = model.sagged?.earth?.interior ?? ""
                switch type {
                case "extreme1":
                    break
                    
                case "extreme2":
                    break
                    
                case "extreme3":
                    let personalVc = PersonalViewController()
                    personalVc.params = ["title": model.sagged?.earth?.uptown ?? "",
                                         "productID": productID,
                                         "orderID": orderID]
                    self.navigationController?.pushViewController(personalVc, animated: true)
                    
                case "extreme4":
                    let contactVc = ContactViewController()
                    contactVc.params = ["title": model.sagged?.earth?.uptown ?? "",
                                        "productID": productID,
                                        "orderID": orderID]
                    self.navigationController?.pushViewController(contactVc, animated: true)
                    
                case "extreme5":
                    let walletVc = WalletViewController()
                    walletVc.params = ["title": model.sagged?.earth?.uptown ?? "",
                                       "productID": productID,
                                       "orderID": orderID]
                    self.navigationController?.pushViewController(walletVc, animated: true)
                    
                default:
                    break
                }
            }
            LoadingView.shared.hide()
        } catch {
            LoadingView.shared.hide()
        }
    }
    
}
