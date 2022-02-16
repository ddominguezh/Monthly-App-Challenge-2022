//
//  Image+Cropped.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 15/2/22.
//

import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
            .clipped()
        }
    }
}
