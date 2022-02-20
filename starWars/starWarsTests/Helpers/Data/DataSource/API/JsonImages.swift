//
//  JsonImages.swift
//  starWarsTests
//
//  Created by Diego Alberto Dominguez Herreros on 9/2/22.
//

import XCTest
@testable import starWars

struct JsonImage: Encodable {
    var name: String
    var image: String
}

class JsonImages: XCTestCase {

    private var items: [JsonImage] = [JsonImage]()
    
    func testExample() throws {
        films(url: String.Empty)
    }

    private func films(url: String) {
        if url.isEmpty {
            FilmAPIImpl().search(
                completion: { result in
                    result.results.forEach {
                        self.items.append(JsonImage(name: $0.title, image: ImageAPIImpl().getUrlImage(name: $0.title)))
                    }
                    if !result.next.isEmpty {
                        self.films(url: result.next)
                    } else {
                        self.printJson()
                    }
                },
                failure: { _ in
                    XCTFail()
                })
        } else {
            FilmAPIImpl().page(
                url: url,
                completion: { result in
                    result.results.forEach {
                        self.items.append(JsonImage(name: $0.title, image: ImageAPIImpl().getUrlImage(name: $0.title)))
                    }
                    if !result.next.isEmpty {
                        self.films(url: result.next)
                    } else {
                        self.printJson()
                    }
                },
                failure: { _ in
                    XCTFail()
                })
        }
    }
    
    private func species(url: String) {
        if url.isEmpty {
            SpeccyAPIImpl().search(
                completion: { result in
                    result.results.forEach {
                        self.items.append(JsonImage(name: $0.name, image: ImageAPIImpl().getUrlImage(name: $0.name)))
                    }
                    if !result.next.isEmpty {
                        self.species(url: result.next)
                    } else {
                        self.printJson()
                    }
                },
                failure: { _ in
                    XCTFail()
                })
        } else {
            SpeccyAPIImpl().page(
                url: url,
                completion: { result in
                    result.results.forEach {
                        self.items.append(JsonImage(name: $0.name, image: ImageAPIImpl().getUrlImage(name: $0.name)))
                    }
                    if !result.next.isEmpty {
                        self.species(url: result.next)
                    } else {
                        self.printJson()
                    }
                },
                failure: { _ in
                    XCTFail()
                })
        }
    }
    
    private func printJson() {
        guard let result = try? JSONEncoder().encode(items) else {
            return
        }
        print(result)
    }
}
