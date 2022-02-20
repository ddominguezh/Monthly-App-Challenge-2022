//
//  PeopleAPIImplTests.swift
//  starWarsTests
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import XCTest
@testable import starWars

class PeopleAPIImplTests: XCTestCase {

    func testSearch() throws {
        let expectation = self.expectation(description: "Search")
        PeopleAPIImpl().search(
            completion: { result in
                XCTAssertGreaterThan(result.count, 0)
                XCTAssertEqual(result.previous, String.Empty)
                XCTAssertEqual(result.next, "\(PeopleAPIImpl.domain)/?page=2")
                XCTAssertEqual(result.results.count, 10)
                expectation.fulfill()
            },
            failure: { _ in
                XCTFail()
                expectation.fulfill()
            })
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testSearchWithFilter() throws {
        let expectation = self.expectation(description: "Search")
        PeopleAPIImpl().search(
            value: "luke",
            completion: { result in
                XCTAssertEqual(result.count, 1)
                XCTAssertEqual(result.previous, String.Empty)
                XCTAssertEqual(result.next, String.Empty)
                XCTAssertEqual(result.results.count, 1)
                expectation.fulfill()
            },
            failure: { _ in
                XCTFail()
                expectation.fulfill()
            })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPage() throws {
        let expectation = self.expectation(description: "Search")
        PeopleAPIImpl().page(
            url: "\(PeopleAPIImpl.domain)/?page=5",
            completion: { result in
                XCTAssertGreaterThan(result.count, 0)
                XCTAssertEqual(result.previous, "\(PeopleAPIImpl.domain)/?page=4")
                XCTAssertEqual(result.next, "\(PeopleAPIImpl.domain)/?page=6")
                XCTAssertEqual(result.results.count, 10)
                expectation.fulfill()
            },
            failure: { _ in
                XCTFail()
                expectation.fulfill()
            })
        waitForExpectations(timeout: 10, handler: nil)
    }

}
