//
//  AbstractRequestFactory.swift
//  Shop
//
//  Created by Дмитрий Скок on 15.06.2023.
//

import Foundation
import Alamofire

// Создание запросов

protocol AbstractRequestFactory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }

    @discardableResult
    func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest
}

extension AbstractRequestFactory {
    @discardableResult
    func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest {
            return sessionManager
                .request(request)
                .responseCodable(errorParser: errorParser,
                                 queue: queue,
                                 completionHandler: completionHandler
                )
        }
}
