//
//  GridHView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import SwiftUI

struct GridHView<Content>: View where Content: View {
    
    private let gridItemLayout = [GridItem(.flexible())]
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItemLayout, spacing: 16.0) {
                self.content()
            }
        }
    }
}

struct GridHView_Previews: PreviewProvider {
    static var previews: some View {
        GridHView() {
            EmptyView()
        }
    }
}
