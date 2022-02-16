//
//  FilmDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import SwiftUI

struct FilmDetailView: View {
    @StateObject var model: FilmDetailViewModel
    
    fileprivate func detail(size: CGSize) -> some View {
        VStack {
            if !model.film.title.isEmpty {
                ImageView(name: model.film.title)
                    .frame(width: 100, height: 100)
            }
            ScrollView {
                self.information()
                if model.planets.count > 0 {
                    Title("Planets")
                    GridHView {
                        ForEach(model.planets){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PlanetRouter.showDetail(planet: item))
                            ).frame(width: size.width / 2)
                        }
                    }
                }
                if model.characeters.count > 0 {
                    Title("Characters")
                    GridHView {
                        ForEach(model.characeters){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PeopleRouter.showDetail(people: item))
                            ).frame(width: size.width / 2)
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
                            ).frame(width: size.width / 2)
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
                            ).frame(width: size.width / 2)
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
                            ).frame(width: size.width / 2)
                        }
                    }
                }
            }
        }
        .navigationTitle(model.film.title)
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
            InformationItemView(name: "Episode", value: "\(self.model.film.episodeId)")
            InformationItemView(name: "Opening Crawl", value: self.model.film.openingCrawl)
            InformationItemView(name: "Director", value: self.model.film.director)
            InformationItemView(name: "Producer", value: self.model.film.producer)
            InformationItemView(name: "Release Date", value: self.model.film.releaseDate)
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

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailView(
            model: FilmDetailViewModel(url: "https://swapi.dev/api/films/1/")
        )
    }
}
