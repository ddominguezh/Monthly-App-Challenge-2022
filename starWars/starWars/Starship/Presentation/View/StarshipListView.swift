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
    
    fileprivate func row(_ starship: StarshipModel) -> some View {
        HStack{
            NavigationLink(destination: StarshipRouter.showDetail(starship: starship)) {
                Text("\(starship.name)")
                    .foregroundColor(Color.black)
            }
        }
    }
    
    fileprivate func list() -> some View {
        List {
            ForEach(model.starships.results.reversed()){ item in
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
            .navigationTitle("Starships")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension StarshipListView {
    func search() {
        if searchText.isEmpty {
            model.all()
        } else {
            model.filter(value: searchText)
        }
    }
}

extension StarshipListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

struct StarshipListView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipListView()
    }
}
