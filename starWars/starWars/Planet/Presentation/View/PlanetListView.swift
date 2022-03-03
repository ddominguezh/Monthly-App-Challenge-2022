//
//  PlanetListView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct PlanetListView: View {

    @StateObject var model = PlanetListViewModel()
    @State var searchText: String = String.Empty

    fileprivate func grid() -> some View {
        GridVView(delegate: self, hasMore: model.planets.count != model.planets.results.count) {
            ForEach(model.planets.results){ item in
                GridCellView(
                    text: item.name,
                    detailView: AnyView(PlanetRouter.showDetail(planet: item))
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
            .navigationTitle(LocalizedStringKey("planets"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension PlanetListView {
    func search() {
        if self.searchText.isEmpty {
            self.model.all()
        } else {
            self.model.filter(value: searchText)
        }
    }
}

extension PlanetListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

extension PlanetListView: GridViewDelegate {
    func more() {
        self.model.next()
    }
}

struct PlanetListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListView()
    }
}
