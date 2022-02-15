//
//  ImageDatasource.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import Foundation

protocol ImageDataSource {
    func getUrlImage(name: String) -> String
}
