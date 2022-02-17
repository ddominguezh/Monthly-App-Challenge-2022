//
//  SpeccyListView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import SwiftUI

struct SpeccyListView: View {

    @StateObject var model = SpeccyListViewModel()
    @State var searchText: String = String.Empty

    fileprivate func list() -> some View {
        GridVView(delegate: self, hasMore: model.species.count != model.species.results.count) {
            ForEach(model.species.results){ item in
                GridCellView(
                    text: item.name,
                    detailView: AnyView(SpeccyRouter.showDetail(speccy: item))
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
        .alert("Error", isPresented: $model.hasError) {
        } message: {
            Text(model.errorMessage)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            BackgroundView(size: geo.size) {
                VStack {
                    SearchBar(delegate: self)
                        .padding(EdgeInsets.init(top: 1, leading: 16, bottom: 1, trailing: 16))
                    list()
                }
            }
            .navigationTitle(LocalizedStringKey("species"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension SpeccyListView {
    func search() {
        if self.searchText.isEmpty {
            self.model.all()
        } else {
            self.model.filter(value: searchText)
        }
    }
}

extension SpeccyListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

extension SpeccyListView: GridViewDelegate {
    func more() {
        self.model.next()
    }
}

struct SpeccyListView_Previews: PreviewProvider {
    static var previews: some View {
        SpeccyListView()
    }
}
