//
//  ImageUseCase.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import Foundation

protocol GetImage {
    func execute(name: String) -> String
}

struct GetImageUseCase: GetImage {
    
    var repository: ImageRepository
    
    func execute(name: String) -> String {
        repository.get(name: name)
    }
}
