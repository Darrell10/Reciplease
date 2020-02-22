//
//  MockAdamanSession.swift
//  RecipleaseTests
//
//  Created by Frederick Port on 15/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//
@testable import  Reciplease

import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class MockAdamanSession: AlamoSession {

    // MARK: - Properties

    private let fakeResponse: FakeResponse
    
    // MARK: - Initializer

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    // MARK: - Methods

    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: nil)
        let urlRequest = URLRequest(url: URL(string: "https://www.apple.com")!)
        callBack(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
