//
//  StarshipDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct StarshipDetailView: View {
    
    @StateObject var model: StarshipDetailViewModel
    
    fileprivate func detail(size: CGSize) -> some View {
        VStack {
            if !model.starship.name.isEmpty {
                ImageView(name: model.starship.name)
                    .frame(width: 100, height: 100)
            }
            ScrollView {
                self.information()
                if model.films.count > 0 {
                    Title("films")
                    GridHView {
                        ForEach(model.films){ item in
                            GridCellView(
                                text: item.title,
                                detailView: AnyView(FilmRouter.showDetail(film: item))
                            ).frame(width: size.width / 2)
                        }
                    }
                }
                if model.pilots.count > 0 {
                    Title("pilots")
                    GridHView {
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
                InformationItemView(name: "model", value: self.model.starship.model)
                InformationItemView(name: "manufacturer", value: self.model.starship.manufacturer)
                InformationItemView(name: "cost-in-credits", value: self.model.starship.costInCredits)
                InformationItemView(name: "length", value: self.model.starship.length)
                InformationItemView(name: "max-atmosphering-speed", value: self.model.starship.maxAtmospheringSpeed)
                InformationItemView(name: "crew", value: self.model.starship.crew)
            }
            VStack(alignment: .leading, spacing: 8) {
                InformationItemView(name: "passengers", value: self.model.starship.passengers)
                InformationItemView(name: "capacity", value: self.model.starship.cargoCapacity)
                InformationItemView(name: "consumables", value: self.model.starship.consumables)
                InformationItemView(name: "hyperdrive-rating", value: self.model.starship.hyperdriveRating)
                InformationItemView(name: "MGLT", value: self.model.starship.MGLT)
                InformationItemView(name: "starship-class", value: self.model.starship.starshipClass)
            }
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

struct StarshipDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipDetailView(
            model: StarshipDetailViewModel (
                url: "https://swapi.dev/api/starships/9/"
            )
        )
    }
}
