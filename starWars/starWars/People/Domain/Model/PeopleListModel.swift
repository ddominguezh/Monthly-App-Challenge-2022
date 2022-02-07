//
//  PeopleListModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import Foundation

struct PeopleListModel {
    var count: Int
    var next: String
    var previous: String
    var results: [PeopleModel]
    
    init(entity: PeopleListAPIEntity) {
        self.init(count: entity.count, next: entity.next ?? String.Empty, previous: entity.previous ?? String.Empty, results: [])
        entity.results.forEach {
            self.results.append(PeopleModel(entity: $0))
        }
    }

    internal init(count: Int, next: String, previous: String, results: [PeopleModel]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

extension PeopleListModel {
    static let NullObject: PeopleListModel = PeopleListModel(
        count: Int.zero,
        next: String.Empty,
        previous: String.Empty,
        results: [])
}

extension PeopleListModel {
    mutating func add(model: PeopleListModel) {
        self.next = model.next
        self.previous = model.previous
        model.results.forEach {
            self.results.append($0)
        }
    }
}
