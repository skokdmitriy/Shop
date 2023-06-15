//
//  AuthRequestFactory.swift
//  Shop
//
//  Created by Дмитрий Скок on 15.06.2023.
//

import Foundation
import Alamofire

// Реализация входа в личный кабинет

protocol AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler: @escaping(AFDataResponse<LoginResult>) -> Void)
}

