//
//  PeopelDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct PeopleDetailView: View {
    
    @StateObject var model: PeopleDetailViewModel
    
    fileprivate func detail() -> some View {
        VStack {
            if !model.people.name.isEmpty {
                ImageView(name: model.people.name)
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
                if model.species.count > 0 {
                    Title("Species")
                    GridHView {
                        ForEach(model.species){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(SpeccyRouter.showDetail(speccy: item))
                            )
                        }
                    }
                }
                if model.starships.count > 0 {
                    Title("Starships")
                    GridHView {
                        ForEach(model.starships){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(StarshipRouter.showDetail(starship: item))
                            )
                        }
                    }
                }
                if model.vehicles.count > 0 {
                    Title("Vehicles")
                    GridHView {
                        ForEach(model.vehicles){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(VehicleRouter.showDetail(vehicle: item))
                            )
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
            InformationItemView(name: "Height", value: self.model.people.height)
            InformationItemView(name: "Mass", value: self.model.people.mass)
            InformationItemView(name: "Hair Color", value: self.model.people.hairColor)
            InformationItemView(name: "Skin Color", value: self.model.people.skinColor)
            InformationItemView(name: "Eye Color", value: self.model.people.eyeColor)
            InformationItemView(name: "Birth Year", value: self.model.people.birthYear)
            InformationItemView(name: "Gender", value: self.model.people.gender)
            InformationItemView(name: "Homeworld", value: self.model.people.homeworld)
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

struct PeopelDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleDetailView(
            model: PeopleDetailViewModel(
                url: "https://swapi.dev/api/people/1/"
            )
        )
    }
}
