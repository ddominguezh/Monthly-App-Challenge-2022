//
//  StarshipListView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct StarshipListView: View {
    
    @StateObject var model = StarshipListViewModel()
    @State var searchText: String = String.Empty
    
    fileprivate func grid() -> some View {
        GridVView(delegate: self, hasMore: model.starships.count != model.starships.results.count) {
            ForEach(model.starships.results){ item in
                GridCellView(
                    text: item.name,
                    detailView: AnyView(StarshipRouter.showDetail(starship: item))
                )
            }
        }
        .overlay {
            if model.fetching {
                CustomProgressView()
            }
        }
        .task {
            self.search()
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            BackgroundView(size: geo.size) {
                VStack {
                    SearchBar(delegate: self)
                        .padding(EdgeInsets.init(top: 1, leading: 16, bottom: 1, trailing: 16))
                    grid()
                }
            }
            .navigationTitle(LocalizedStringKey("starships"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension StarshipListView {
    func search() {
        if self.searchText.isEmpty {
            self.model.all()
        } else {
            self.model.filter(value: searchText)
        }
    }
}

extension StarshipListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

extension StarshipListView: GridViewDelegate {
    func more() {
        self.model.next()
    }
}

struct StarshipListView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipListView()
    }
}
