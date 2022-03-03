//
//  PeopelDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct PeopleDetailView: View {

    @StateObject var model: PeopleDetailViewModel
    
    fileprivate func detail(size: CGSize) -> some View {
        VStack {
            if !model.people.name.isEmpty {
                DetailImage(name: model.people.name)
            }
            ScrollView {
                self.information()
                if !model.homeworld.name.isEmpty {
                    GridHView(title: "homeworld"){
                        GridCellView(
                            text: model.homeworld.name,
                            detailView: AnyView(PlanetRouter.showDetail(planet: model.homeworld))
                        ).frame(width: size.width / 2)
                    }
                }
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
                if model.species.count > 0 {
                    GridHView(title: "species"){
                        ForEach(model.species){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(SpeccyRouter.showDetail(speccy: item))
                            ).frame(width: size.width / 2)
                        }
                    }
                }
                if model.starships.count > 0 {
                    GridHView(title: "starships"){
                        ForEach(model.starships){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(StarshipRouter.showDetail(starship: item))
                            ).frame(width: size.width / 2)
                        }
                    }
                }
                if model.vehicles.count > 0 {
                    GridHView(title: "vehicles"){
                        ForEach(model.vehicles){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(VehicleRouter.showDetail(vehicle: item))
                            ).frame(width: size.width / 2)
                        }
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle(model.people.name)
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
            InformationItemView(name: "height", value: self.model.people.height)
            InformationItemView(name: "mass", value: self.model.people.mass)
            InformationItemView(name: "hair-color", value: self.model.people.hairColor)
            InformationItemView(name: "skin-color", value: self.model.people.skinColor)
            InformationItemView(name: "eye-color", value: self.model.people.eyeColor)
            InformationItemView(name: "birth-year", value: self.model.people.birthYear)
            InformationItemView(name: "gender", value: self.model.people.gender)
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

struct PeopelDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleDetailView(
            model: PeopleDetailViewModel(
                url: "\(PeopleAPIImpl.domain)/1/"
            )
        )
    }
}
