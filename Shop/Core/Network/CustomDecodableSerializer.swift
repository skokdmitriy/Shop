//
//  CustomDecodableSerializer.swift
//  Shop
//
//  Created by Дмитрий Скок on 14.06.2023.
//

import Foundation
import Alamofire

// DataRequest(разбор данный)

class CustomDecodableSerializer<T: Decodable>: DataResponseSerializerProtocol {
    private let errorParser: AbstractErrorParser

    // MARK: - Init

    init(errorParser: AbstractErrorParser) {
        self.errorParser = errorParser
    }

    func serialize(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?) throws -> T {
            if let error = errorParser.parse(response: response, data: data, error: error) {
                throw error
            }
            do {
                let data = try DataResponseSerializer().serialize(request: request,
                                                                  response: response,
                                                                  data: data,
                                                                  error: error
                )
                let value = try JSONDecoder().decode(T.self, from: data)
                return value
            } catch {
                let customError = errorParser.parse(error)
                throw customError
            }
        }
}

// MARK: - DataRequest

extension DataRequest {
    @discardableResult
    func responseCodable<T: Decodable>(
        errorParser: AbstractErrorParser,
        queue: DispatchQueue = .main,
        completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self{
            let responseSerialize = CustomDecodableSerializer<T>(errorParser: errorParser)
            return response(queue: queue,
                            responseSerializer: responseSerialize,
                            completionHandler: completionHandler
            )
        }
}
