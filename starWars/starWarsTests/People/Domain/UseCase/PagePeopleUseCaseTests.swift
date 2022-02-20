//
//  PagePeopleUseCaseTests.swift
//  starWarsTests
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import XCTest
@testable import starWars

class PagePeopleUseCaseTests: XCTestCase {
    
    func testExecute() throws {
        let expectation = self.expectation(description: "Search")
        let useCase = PagePeopleUseCase(repository: PeopleRepositoryImpl(dataSource: PeopleAPIImpl()))
        useCase.execute(url: "\(PeopleAPIImpl.domain)/?page=5") {
            switch $0 {
            case .success(let result):
                XCTAssertGreaterThan(result.count, 0)
                XCTAssertEqual(result.previous, "\(PeopleAPIImpl.domain)/?page=4")
                XCTAssertEqual(result.next, "\(PeopleAPIImpl.domain)/?page=6")
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
