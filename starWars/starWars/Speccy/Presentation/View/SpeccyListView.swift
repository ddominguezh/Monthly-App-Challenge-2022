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

    fileprivate func row(_ speccy: SpeccyModel) -> some View {
        HStack{
            NavigationLink(destination: SpeccyRouter.showDetail(speccy: speccy)) {
                Text("\(speccy.name)")
                    .foregroundColor(Color.black)
            }
        }
    }
    
    fileprivate func list() -> some View {
        List {
            ForEach(model.species.results.reversed()){ item in
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
            .navigationTitle("Species")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension SpeccyListView {
    func search() {
        if searchText.isEmpty {
            model.all()
        } else {
            model.filter(value: searchText)
        }
    }
}

extension SpeccyListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

struct SpeccyListView_Previews: PreviewProvider {
    static var previews: some View {
        SpeccyListView()
    }
}
