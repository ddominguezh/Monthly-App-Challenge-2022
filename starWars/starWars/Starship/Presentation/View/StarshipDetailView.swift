//
//  StarshipDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct StarshipDetailView: View {
    
    @StateObject var model: StarshipDetailViewModel
    
    fileprivate func detail() -> some View {
        VStack {
            if !model.starship.name.isEmpty {
                ImageView(name: model.starship.name)
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
        .navigationTitle(model.starship.name)
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
            VStack(alignment: .leading, spacing: 8) {
                InformationItemView(name: "Model", value: self.model.starship.model)
                InformationItemView(name: "Manufacturer", value: self.model.starship.manufacturer)
                InformationItemView(name: "Cost In Credits", value: self.model.starship.costInCredits)
                InformationItemView(name: "Length", value: self.model.starship.length)
                InformationItemView(name: "Max Atmosphering Speed", value: self.model.starship.maxAtmospheringSpeed)
                InformationItemView(name: "Crew", value: self.model.starship.crew)
            }
            VStack(alignment: .leading, spacing: 8) {
                InformationItemView(name: "Passengers", value: self.model.starship.passengers)
                InformationItemView(name: "Capacity", value: self.model.starship.cargoCapacity)
                InformationItemView(name: "Consumables", value: self.model.starship.consumables)
                InformationItemView(name: "Hyperdrive Rating", value: self.model.starship.hyperdriveRating)
                InformationItemView(name: "MGLT", value: self.model.starship.MGLT)
                InformationItemView(name: "Starship Class", value: self.model.starship.starshipClass)
            }
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

struct StarshipDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipDetailView(
            model: StarshipDetailViewModel (
                url: "https://swapi.dev/api/starships/9/"
            )
        )
    }
}
