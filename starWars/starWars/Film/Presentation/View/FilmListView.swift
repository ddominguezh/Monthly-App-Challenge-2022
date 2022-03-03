//
//  FilmListView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import SwiftUI

struct FilmListView: View {

    @StateObject var model = FilmListViewModel()
    @State var searchText: String = String.Empty

    fileprivate func grid() -> some View {
        GridVView(delegate: self, hasMore: model.films.count != model.films.results.count) {
            ForEach(model.films.results){ item in
                GridCellView(
                    text: item.title,
                    detailView: AnyView(FilmRouter.showDetail(film: item))
                )
            }
        }
        .overlay {
            if model.fetching {
                CustomProgressView()
            }
        }
        .refreshable {
            model.next()
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
            .navigationTitle(LocalizedStringKey("films"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension FilmListView {
    func search() {
        if self.searchText.isEmpty {
            self.model.all()
        } else {
            self.model.filter(value: searchText)
        }
    }
}

extension FilmListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

extension FilmListView: GridViewDelegate {
    func more() {
        self.model.next()
    }
}

struct FilmListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListView()
    }
}
