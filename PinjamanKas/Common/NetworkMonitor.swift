//
//  NetworkMonitor.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/22.
//

import Foundation
import Alamofire

final class NetworkMonitor {

    static let shared = NetworkMonitor()

    var statusChanged: ((NetworkReachabilityManager.NetworkReachabilityStatus) -> Void)?

    private let manager = NetworkReachabilityManager()
    private var isListening = false

    private init() {}

    func startListening() {
        guard isListening == false else { return }
        isListening = true

        manager?.startListening(onUpdatePerforming: { [weak self] status in
            self?.statusChanged?(status)
        })
    }

    func stopListening() {
        guard isListening else { return }
        isListening = false

        manager?.stopListening()
    }
}
