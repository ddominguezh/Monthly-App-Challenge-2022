//
//  PlanetDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct PlanetDetailView: View {
    
    @StateObject var model: PlanetDetailViewModel
    
    fileprivate func detail(size: CGSize) -> some View {
        VStack {
            if !model.planet.name.isEmpty {
                ImageView(name: model.planet.name)
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
                if model.residents.count > 0 {
                    Title("residents")
                    GridHView {
                        ForEach(model.residents){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PeopleRouter.showDetail(people: item))
                            ).frame(width: size.width / 2)
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
            InformationItemView(name: "rotation-period", value: self.model.planet.rotationPeriod)
            InformationItemView(name: "orbital-period", value: self.model.planet.orbitalPeriod)
            InformationItemView(name: "diameter", value: self.model.planet.diameter)
            InformationItemView(name: "climate", value: self.model.planet.climate)
            InformationItemView(name: "gravity", value: self.model.planet.gravity)
            InformationItemView(name: "terrain", value: self.model.planet.terrain)
            InformationItemView(name: "surface-water", value: self.model.planet.surfaceWater)
            InformationItemView(name: "population", value: self.model.planet.population)
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

struct PlanetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetDetailView(
            model: PlanetDetailViewModel(
                url: "https://swapi.dev/api/planets/3/"
            )
        )
    }
}
