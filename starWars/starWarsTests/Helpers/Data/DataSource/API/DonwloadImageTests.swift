//
//  DonwloadImageTests.swift
//  starWarsTests
//
//  Created by Diego Alberto Dominguez Herreros on 7/2/22.
//

import XCTest
@testable import starWars

class DonwloadImageTests: XCTestCase {
    func testExample() throws {
        let image = DonwloadImage(name: "boba fett").getFirstImage()
        XCTAssertNotNil(image)
    }
}
