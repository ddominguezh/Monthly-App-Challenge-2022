//
//  PageStarshipUseCaseTests.swift
//  starWarsTests
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import XCTest
@testable import starWars

class PageStarshipUseCaseTests: XCTestCase {

    func testExecute() throws {
        let expectation = self.expectation(description: "Search")
        let useCase = PageStarshipUseCase(repository: StarshipRepositoryImpl(dataSource: StarshipAPIImpl()))
        useCase.execute(url: "\(StarshipAPIImpl.domain)/?page=2") {
            switch $0 {
            case .success(let result):
                XCTAssertGreaterThan(result.count, 0)
                XCTAssertEqual(result.previous, "\(StarshipAPIImpl.domain)/?page=1")
                XCTAssertEqual(result.next, "\(StarshipAPIImpl.domain)/?page=3")
                XCTAssertEqual(result.results.count, 10)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}
