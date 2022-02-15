//
//  GoogleSearchResponse.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 8/2/22.
//

import Foundation

struct GoogleSearchResponse: Codable {
    var items: [Item]
}

struct Item: Codable {
    var link: String
}
