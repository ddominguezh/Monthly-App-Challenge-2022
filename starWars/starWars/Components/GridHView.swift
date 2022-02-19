//
//  GridHView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import SwiftUI

struct GridHView<Content>: View where Content: View {
    
    private let gridItemLayout = [GridItem(.flexible())]
    let title: String
    let content: () -> Content
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack {
            Title(self.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 16.0) {
                    self.content()
                }
            }
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .frame(height: 1)
        }
    }
}

struct GridHView_Previews: PreviewProvider {
    static var previews: some View {
        GridHView(title: String.Empty) {
            EmptyView()
        }
    }
}
