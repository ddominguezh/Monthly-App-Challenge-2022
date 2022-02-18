//
//  VehicleDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import SwiftUI

struct VehicleDetailView: View {
    @StateObject var model: VehicleDetailViewModel
    
    fileprivate func detail(size: CGSize) -> some View {
        VStack {
            if !model.vehicle.name.isEmpty {
                DetailImage(name: model.vehicle.name)
            }
            ScrollView {
                self.information()
                if model.films.count > 0 {
                    GridHView(title: "films"){
                        ForEach(model.films){ item in
                            GridCellView(
                                text: item.title,
                                detailView: AnyView(FilmRouter.showDetail(film: item))
                            ).frame(width: size.width / 2)
                        }
                    }
                }
                if model.pilots.count > 0 {
                    GridHView(title: "pilots"){
                        ForEach(model.pilots){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PeopleRouter.showDetail(people: item))
                            ).frame(width: size.width / 2)
                        }
                    }
                }
            }
        }
        .navigationTitle(model.vehicle.name)
        .overlay {
            if model.fetching {
                CustomProgressView()
            }
        }
        .task {
            model.detail()
        }
        .alert("Error", isPresented: $model.hasError) {
        } message: {
            Text(model.errorMessage)
        }
    }
    
    fileprivate func information() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            InformationItemView(name: "manufacturer", value: self.model.vehicle.manufacturer)
            InformationItemView(name: "cost-in-credits", value: self.model.vehicle.costInCredits)
            InformationItemView(name: "length", value: self.model.vehicle.length)
            InformationItemView(name: "max-atmosphering-speed", value: self.model.vehicle.maxAtmospheringSpeed)
            InformationItemView(name: "crew", value: self.model.vehicle.crew)
            InformationItemView(name: "passengers", value: self.model.vehicle.passengers)
            InformationItemView(name: "capacity", value: self.model.vehicle.cargoCapacity)
            InformationItemView(name: "consumables", value: self.model.vehicle.consumables)
            InformationItemView(name: "vehicle-class", value: self.model.vehicle.vehicleClass)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            BackgroundView(size: geo.size) {
                detail(size: geo.size)
            }
            .navigationTitle("Starships")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct VehicleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailView(
            model: VehicleDetailViewModel(url: "https://swapi.dev/api/vehicles/14/")
        )
    }
}
