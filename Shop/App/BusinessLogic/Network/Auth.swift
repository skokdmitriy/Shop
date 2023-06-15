//
//  Auth.swift
//  Shop
//
//  Created by Дмитрий Скок on 15.06.2023.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: Constants.baseUrl)

    init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Auth: AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler: @escaping (Alamofire.AFDataResponse<LoginResult>) -> Void) {
        guard let baseUrl else {
            return
        }
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "login.json"
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
}
