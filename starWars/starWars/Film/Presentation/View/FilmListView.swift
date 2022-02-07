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
    
    fileprivate func row(_ film: FilmModel) -> some View {
        HStack{
            NavigationLink(destination: FilmRouter.showDetail(film: film)) {
                Text("\(film.title)")
                    .foregroundColor(Color.black)
            }
        }
    }
    
    fileprivate func list() -> some View {
        List {
            ForEach(model.films.results.reversed()){ item in
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
            .navigationTitle("Films")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension FilmListView {
    func search() {
        if searchText.isEmpty {
            model.all()
        } else {
            model.filter(value: searchText)
        }
    }
}

extension FilmListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

struct FilmListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListView()
    }
}
