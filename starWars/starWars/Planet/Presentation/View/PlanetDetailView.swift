//
//  PlanetDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct PlanetDetailView: View {
    
    @StateObject var model: PlanetDetailViewModel
    
    fileprivate func detail() -> some View {
        VStack {
            if !model.planet.name.isEmpty {
                ImageView(name: model.planet.name)
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
                if model.residents.count > 0 {
                    Title("Residents")
                    GridHView {
                        ForEach(model.residents){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PeopleRouter.showDetail(people: item))
                            )
                        }
                    }
                }
            }
        }
        .navigationTitle(model.planet.name)
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
            InformationItemView(name: "Rotation Period", value: self.model.planet.rotationPeriod)
            InformationItemView(name: "Orbital Period", value: self.model.planet.orbitalPeriod)
            InformationItemView(name: "Diameter", value: self.model.planet.diameter)
            InformationItemView(name: "Climate", value: self.model.planet.climate)
            InformationItemView(name: "Gravity", value: self.model.planet.gravity)
            InformationItemView(name: "Terrain", value: self.model.planet.terrain)
            InformationItemView(name: "Surface Water", value: self.model.planet.surfaceWater)
            InformationItemView(name: "Population:", value: self.model.planet.population)
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

struct PlanetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetDetailView(
            model: PlanetDetailViewModel(
                url: "https://swapi.dev/api/planets/3/"
            )
        )
    }
}
