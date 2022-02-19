//
//  GridView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import SwiftUI

protocol GridViewDelegate {
    func more()
}

struct GridVView<Content>: View where Content: View {
    
    private let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var delegate: GridViewDelegate?
    var hasMore: Bool = false
    let content: () -> Content
    
    init(delegate: GridViewDelegate, hasMore: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.init(hasMore: hasMore, content: content)
        self.delegate = delegate
    }
    
    init(hasMore: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.hasMore = hasMore
        self.content = content
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridItemLayout, spacing: 16.0) {
                self.content()
            }
            if self.hasMore {
                Button(action: {
                    self.delegate?.more()
                }, label: {
                    Text(LocalizedStringKey("more"))
                        .foregroundColor(.white)
                })
            }
        }
    }
}

struct GridVView_Previews: PreviewProvider {
    static var previews: some View {
        GridVView(hasMore: false) {
            EmptyView()
        }
    }
}
