//
//  ImageView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import SwiftUI

struct ImageView: View {
    
    @StateObject var model: ImageViewModel = ImageViewModel()
    var name: String

    var body: some View {
        AsyncImage(
            url: URL(string: model.url),
            content: { image in
                image.resizable()
                    //.scaledToFill()
                    .centerCropped()
            },
            placeholder: {
                CustomProgressView()
            }
        )
        .task {
            model.load(name: self.name)
        }
        //.background(Color.background)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(name: "yoda")
    }
}
