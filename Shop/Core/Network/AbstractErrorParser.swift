//
//  AbstractErrorParser.swift
//  Shop
//
//  Created by Дмитрий Скок on 14.06.2023.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
