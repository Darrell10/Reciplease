//
//  AdamanServiceTests.swift
//  RecipleaseTests
//
//  Created by Frederick Port on 15/02/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

@testable import Reciplease
import XCTest


final class AdamanServiceTests: XCTestCase {
    
    var text = ["Tagada"]
    
    func testGetrecipe_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockAdamanSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipe(text: text) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipe method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetrecipe_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockAdamanSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipe(text: text) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipe method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetrecipe_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockAdamanSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipe(text: text) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipe method with undecodable data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = MockAdamanSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipe(text: text) { result in
            guard case .success(let data) = result else {
                XCTFail("Test getData method with correct data failed.")
                return
            }
            XCTAssertTrue(data.hits[0].recipe.label == "Sweet Berry Froyo Treats")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
}
