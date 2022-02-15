//
//  ImageViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import Foundation

class ImageViewModel: ObservableObject {

    let readerUseCase = GetImageUseCase(repository: ImageRepositoryImpl(dataSource: ImageFileImpl()))
    let downloadUseCase = GetImageUseCase(repository: ImageRepositoryImpl(dataSource: ImageAPIImpl()))
    @Published var fetching = false
    @Published var url: String = String.Empty
    
    func load(name: String) {
        self.url = readerUseCase.execute(name: name)
        if self.url.isEmpty {
            self.url = downloadUseCase.execute(name: name)
        }
    }

}
