//
//  VehicleAPIImplTests.swift
//  starWarsTests
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import XCTest
@testable import starWars

class VehicleAPIImplTests: XCTestCase {

    func testSearch() throws {
        let expectation = self.expectation(description: "Search")
        VehicleAPIImpl().search(
            completion: { result in
                XCTAssertGreaterThan(result.count, 0)
                XCTAssertEqual(result.previous, String.Empty)
                XCTAssertEqual(result.next, "\(VehicleAPIImpl.domain)/?page=2")
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
        VehicleAPIImpl().search(
            value: "on",
            completion: { result in
                XCTAssertEqual(result.count, 8)
                XCTAssertEqual(result.previous, String.Empty)
                XCTAssertEqual(result.next, String.Empty)
                XCTAssertEqual(result.results.count, 8)
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
        VehicleAPIImpl().page(
            url: "\(VehicleAPIImpl.domain)/?page=2",
            completion: { result in
                XCTAssertGreaterThan(result.count, 0)
                XCTAssertEqual(result.previous, "\(VehicleAPIImpl.domain)/?page=1")
                XCTAssertEqual(result.next, "\(VehicleAPIImpl.domain)/?page=3")
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
