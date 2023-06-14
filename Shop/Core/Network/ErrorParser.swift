//
//  ErrorParser.swift
//  Shop
//
//  Created by Дмитрий Скок on 14.06.2023.
//

import Foundation

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        result
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        error
    }
}
