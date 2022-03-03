//
//  PeopleListView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct PeopleListView: View {
    
    @StateObject var model = PeopleListViewModel()
    @State var searchText: String = String.Empty
    
    fileprivate func grid() -> some View {
        GridVView(delegate: self, hasMore: model.peoples.count != model.peoples.results.count) {
            ForEach(model.peoples.results){ item in
                GridCellView(
                    text: item.name,
                    detailView: AnyView(PeopleRouter.showDetail(people: item))
                )
            }
        }
        .background(.clear)
        .listStyle(SidebarListStyle())
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
            .navigationTitle(LocalizedStringKey("peoples"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension PeopleListView {
    func search() {
        if self.searchText.isEmpty {
            self.model.all()
        } else {
            self.model.filter(value: searchText)
        }
    }
}

extension PeopleListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

extension PeopleListView: GridViewDelegate {
    func more() {
        model.next()
    }
}
struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView()
    }
}
