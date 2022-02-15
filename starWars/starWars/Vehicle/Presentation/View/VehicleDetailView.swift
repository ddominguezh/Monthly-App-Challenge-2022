//
//  VehicleDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import SwiftUI

struct VehicleDetailView: View {
    @StateObject var model: VehicleDetailViewModel
    
    fileprivate func detail() -> some View {
        VStack {
            if !model.vehicle.name.isEmpty {
                ImageView(name: model.vehicle.name)
            }
            ScrollView {
                self.information()
                if model.films.count > 0 {
                    Title("Films")
                    GridHView {
                        ForEach(model.films){ item in
                            GridCellView(
                                text: item.title,
                                detailView: AnyView(FilmRouter.showDetail(film: item))
                            )
                        }
                    }
                }
                if model.pilots.count > 0 {
                    Title("Pilots")
                    GridHView {
                        ForEach(model.pilots){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PeopleRouter.showDetail(people: item))
                            )
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
            InformationItemView(name: "Manufacturer", value: self.model.vehicle.manufacturer)
            InformationItemView(name: "Cost In Credits", value: self.model.vehicle.costInCredits)
            InformationItemView(name: "Length", value: self.model.vehicle.length)
            InformationItemView(name: "Max Atmosphering Speed", value: self.model.vehicle.maxAtmospheringSpeed)
            InformationItemView(name: "Crew", value: self.model.vehicle.crew)
            InformationItemView(name: "Passengers", value: self.model.vehicle.passengers)
            InformationItemView(name: "Capacity", value: self.model.vehicle.cargoCapacity)
            InformationItemView(name: "Consumables", value: self.model.vehicle.consumables)
            InformationItemView(name: "Vehicle Class", value: self.model.vehicle.vehicleClass)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            BackgroundView(size: geo.size) {
                detail()
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
