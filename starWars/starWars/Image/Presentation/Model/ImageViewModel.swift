//
//  ImageViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import Foundation
import UIKit

class ImageViewModel: ObservableObject {

    let readerUseCase = GetImageUseCase(repository: ImageRepositoryImpl(dataSource: ImageFileImpl()))
    let downloadUseCase = GetImageUseCase(repository: ImageRepositoryImpl(dataSource: ImageAPIImpl()))
    @Published var fetching = false
    @Published var image: UIImage = UIImage()
    
    func load(name: String) {
        if let image = ImageCache.getImageCache().get(forKey: name) {
            self.image = image
        } else {
            var urlString = readerUseCase.execute(name: name)
            if urlString.isEmpty {
                urlString = downloadUseCase.execute(name: name)
            }
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.image = image
                        ImageCache.getImageCache().set(forKey: name, image: image)
                    }
                }
            }
            task.resume()
        }
    }

}
