//
//  ImageRepository.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import Foundation

protocol ImageRepository {
    func get(name: String) -> String
}
