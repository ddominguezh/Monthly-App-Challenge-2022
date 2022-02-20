//
//  AllFilmUseCaseTests.swift
//  starWarsTests
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import XCTest
@testable import starWars

class AllFilmUseCaseTests: XCTestCase {

    func testExecute() throws {
        let expectation = self.expectation(description: "Search")
        let useCase = AllFilmUseCase(repository: FilmRepositoryImpl(dataSource: FilmAPIImpl()))
        useCase.execute {
            switch $0 {
            case .success(let result):
                XCTAssertGreaterThan(result.count, 0)
                XCTAssertEqual(result.previous, String.Empty)
                XCTAssertEqual(result.next, String.Empty)
                XCTAssertEqual(result.results.count, 7)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}
