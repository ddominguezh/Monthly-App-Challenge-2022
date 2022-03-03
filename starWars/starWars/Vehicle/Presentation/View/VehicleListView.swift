//
//  VehicleListView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import SwiftUI

struct VehicleListView: View {

    @StateObject var model = VehicleListViewModel()
    @State var searchText: String = String.Empty

    fileprivate func grid() -> some View {
        GridVView(delegate: self, hasMore: model.vehicles.count != model.vehicles.results.count) {
            ForEach(model.vehicles.results){ item in
                GridCellView(
                    text: item.name,
                    detailView: AnyView(VehicleRouter.showDetail(vehicle: item))
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
            .navigationTitle(LocalizedStringKey("vehicles"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension VehicleListView {
    func search() {
        if self.searchText.isEmpty {
            self.model.all()
        } else {
            self.model.filter(value: searchText)
        }
    }
}

extension VehicleListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

extension VehicleListView: GridViewDelegate {
    func more() {
        self.model.next()
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView()
    }
}
