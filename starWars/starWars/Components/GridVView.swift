//
//  GridView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 11/2/22.
//

import SwiftUI
import Combine

protocol GridViewDelegate {
    func more()
}

struct GridVView<Content>: View where Content: View {
    
    private let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    let detector: CurrentValueSubject<CGFloat, Never>
    let publisher: AnyPublisher<CGFloat, Never>
    
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
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
        self.detector = detector
    }

    var body: some View {
        GeometryReader { insideProxy in
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: gridItemLayout, spacing: 16.0) {
                    self.content()
                }
                .background(GeometryReader {
                    Color.clear.preference(key: OffsetPreferenceKey.self,
                                           value: $0.size.height + $0.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(OffsetPreferenceKey.self) { detector.send($0) }
            }
            .coordinateSpace(name: "scroll")
            .onReceive(publisher) {
                if self.hasMore && insideProxy.size.height == $0 {
                    self.delegate?.more()
                }
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

private struct OffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
