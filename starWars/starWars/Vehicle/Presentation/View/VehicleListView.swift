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

    fileprivate func row(_ vehicle: VehicleModel) -> some View {
        HStack{
            NavigationLink(destination: VehicleRouter.showDetail(vehicle: vehicle)) {
                Text("\(vehicle.name)")
                    .foregroundColor(Color.black)
            }
        }
    }
    
    fileprivate func list() -> some View {
        List {
            ForEach(model.vehicles.results.reversed()){ item in
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
            .navigationTitle("Vehicles")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension VehicleListView {
    func search() {
        if searchText.isEmpty {
            model.all()
        } else {
            model.filter(value: searchText)
        }
    }
}

extension VehicleListView: SearchBarDelegate {
    func onChange(text: String) {
        self.searchText = text
        self.search()
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView()
    }
}
