//
//  ResponseCodableTests.swift
//  ShopTests
//
//  Created by Дмитрий Скок on 17.06.2023.
//

import Alamofire
import XCTest
@testable import Shop

enum ApiErrorStub: Error {
    case fatalError
}

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct ErrorParseStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

final class ResponseCodableTests: XCTestCase {
    let expectation = XCTestExpectation(description: "Download \(Constants.validateUrl)")
    var errorParse: ErrorParseStub!

    override func setUpWithError() throws {
        errorParse = ErrorParseStub()
    }

    override func tearDownWithError() throws {
        errorParse = nil
    }

    func testShouldDownloadAndParse() {
        let errorParser = ErrorParseStub()
        AF
            .request(Constants.validateUrl)
            .responseCodable(errorParser: errorParser) {[weak self] (response: AFDataResponse<PostStub>) in
                switch response.result {
                case .success(_): break
                case.failure:
                    XCTFail()
                }
                guard let self else {
                    return
                }
                self.expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
    }
}
