//
//  DetailImage.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 18/2/22.
//

import SwiftUI

struct DetailImage: View {
    var name: String
    
    var body: some View {
        ImageView(name: self.name)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.whiteAlpha, lineWidth: 3))
    }
}

struct DetailImage_Previews: PreviewProvider {
    static var previews: some View {
        DetailImage(name: String.Empty)
    }
}
