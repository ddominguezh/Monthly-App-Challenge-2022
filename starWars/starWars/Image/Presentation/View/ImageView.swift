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
                    .transition(.scale(scale: 0.1, anchor: .center))
            },
            placeholder: {
                CustomProgressView()
            }
        )
        .task {
            model.load(name: self.name)
        }
        .frame(maxWidth: 100.0, maxHeight: 100.0)
        .background(Color.background)
        .clipShape(Circle())
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(name: "yoda")
    }
}
