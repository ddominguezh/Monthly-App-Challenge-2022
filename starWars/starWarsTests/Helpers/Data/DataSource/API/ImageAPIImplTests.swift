//
//  ImageAPIImplTests.swift
//  starWarsTests
//
//  Created by Diego Alberto Dominguez Herreros on 7/2/22.
//

import XCTest
@testable import starWars

class ImageAPIImplTests: XCTestCase {
    func testExample() throws {
        let image = ImageAPIImpl().getUrlImage(name: "boba fett")
        XCTAssertNotNil(image)
    }
}
