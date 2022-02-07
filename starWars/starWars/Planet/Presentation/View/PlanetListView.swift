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
    
    fileprivate func row(_ planet: PlanetModel) -> some View {
        HStack{
            NavigationLink(destination: PlanetRouter.showDetail(planet: planet)) {
                Text("\(planet.name)")
                    .foregroundColor(Color.black)
            }
        }
    }
    
    fileprivate func list() -> some View {
        List {
            ForEach(model.planets.results.reversed()){ item in
                row(item)
            }
            .listRowBackground(Color.background)
        }
        .overlay {
            if model.fetching {
                ProgressView("Fetching data, please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            }
        }
        .refreshable {
            model.next()
        }
        .task {
            self.search()
        }
        .onAppear() {
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        }
        .alert("Error", isPresented: $model.hasError) {
        } message: {
            Text(model.errorMessage)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("death_start")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height)
                VStack {
                    SearchBar(delegate: self)
                    list()
                }
            }
            .navigationTitle("Planets")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension PlanetListView {
    func search() {
        if searchText.isEmpty {
            model.all()
        } else {
            model.filter(value: searchText)
        }
    }
}

extension PlanetListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

struct PlanetListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListView()
    }
}
