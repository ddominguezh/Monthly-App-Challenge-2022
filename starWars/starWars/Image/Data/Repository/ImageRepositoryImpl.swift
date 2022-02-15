//
//  ImageRepositoryImpl.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import Foundation

struct ImageRepositoryImpl: ImageRepository {

    var dataSource: ImageDataSource

    func get(name: String) -> String {
        dataSource.getUrlImage(name: name)
    }
}
