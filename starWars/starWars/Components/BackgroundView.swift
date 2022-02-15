//
//  BackgroundView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import SwiftUI

struct BackgroundView<Content> : View where Content: View {
    
    var size: CGSize
    let content: () -> Content

    init(size: CGSize, @ViewBuilder content: @escaping () -> Content) {
        self.size = size
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Image("death_start")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: size.width, height: size.height)
            Rectangle()
                .background(Color.blackAlpha)
                .foregroundColor(.clear)
                .frame(width: size.width, height: size.height)
            content()
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(size: CGSize.zero){
            EmptyView()
        }
    }
}
