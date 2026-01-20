//
//  NetworkManager.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

import UIKit
import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()
    
    private init() {}

    private let timeout: TimeInterval = 30
    
    private let base_url = "http://8.215.85.208:9703/faci"
}

extension NetworkManager {

    func request<T: Decodable>(
        _ url: String,
        method: HTTPMethod,
        params: [String: Any] = [:]
    ) async throws -> T {

        return try await withCheckedThrowingContinuation { continuation in

            let encoding: ParameterEncoding = URLEncoding.default

            let apiUrl = URLParameterBuilder.appendParams(to: base_url + url)
            
            AF.request(
                apiUrl,
                method: method,
                parameters: params,
                encoding: encoding,
                requestModifier: { $0.timeoutInterval = self.timeout }
            )
            .validate()
            .responseDecodable(of: T.self) { response in

                switch response.result {
                case .success(let model):
                    continuation.resume(returning: model)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

extension NetworkManager {

    func uploadFile<T: Decodable>(
        url: String,
        params: [String: Any] = [:],
        fileData: Data,
        fileKey: String = "youngest",
        fileName: String = "youngest.jpg",
        mimeType: String = "application/octet-stream"
    ) async throws -> T {

        return try await withCheckedThrowingContinuation { continuation in

            let apiUrl = URLParameterBuilder.appendParams(to: base_url + url)
            
            AF.upload(
                multipartFormData: { formData in

                    for (key, value) in params {
                        let data = "\(value)".data(using: .utf8)!
                        formData.append(data, withName: key)
                    }

                    formData.append(
                        fileData,
                        withName: fileKey,
                        fileName: fileName,
                        mimeType: mimeType
                    )

                },
                to: apiUrl,
                requestModifier: { $0.timeoutInterval = self.timeout }
            )
            .validate()
            .responseDecodable(of: T.self) { response in

                switch response.result {
                case .success(let model):
                    continuation.resume(returning: model)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
