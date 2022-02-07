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
    
    fileprivate func row(_ people: PeopleModel) -> some View {
        HStack{
            NavigationLink(destination: PeopleRouter.showDetail(people: people)) {
                Text("\(people.name)")
                    .foregroundColor(Color.black)
            }
        }
    }
    
    fileprivate func list() -> some View {
        List {
            ForEach(model.peoples.results.reversed()){ item in
                row(item)
            }
            .listRowBackground(Color.background)
            .listItemTint(Color.black)
            .listRowSeparatorTint(Color.black)
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
                        .padding(EdgeInsets.init(top: 16, leading: 16, bottom: 16, trailing: 16))
                    list()
                }
            }
            .navigationTitle("Peoples")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension PeopleListView {
    func search() {
        if searchText.isEmpty {
            model.all()
        } else {
            model.filter(value: searchText)
        }
    }
}

extension PeopleListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView()
    }
}
