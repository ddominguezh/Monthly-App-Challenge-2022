//
//  Configuration.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 20/2/22.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

extension Configuration {
    
    static var apiURL: URL {
        return try! URL(string: "https://" + self.value(for: "API_URL"))!
    }
    
}
