//
//  FilmDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import SwiftUI

struct FilmDetailView: View {
    
    @StateObject var model: FilmDetailViewModel
    @State var offset: CGFloat = 0
    
    fileprivate func detail(size: CGSize) -> some View {
        VStack {
            if !model.film.title.isEmpty {
                DetailImage(name: model.film.title)
            }
            ScrollView {
                self.information(size: size)
                if model.planets.count > 0 {
                    GridHView(title: "planets"){
                        ForEach(model.planets){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PlanetRouter.showDetail(planet: item))
                            ).frame(width: size.width / 2)
                        }
                    }
                }
                if model.characeters.count > 0 {
                    GridHView(title: "characters"){
                        ForEach(model.characeters){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PeopleRouter.showDetail(people: item))
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
        }
        .navigationTitle(model.film.title)
        .overlay {
            if model.fetching {
                CustomProgressView()
            }
        }
    }
    
    fileprivate func information(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            InformationItemView(name: "episode", value: "\(self.model.film.episodeId)")
            VStack(alignment: .leading) {
                Text("opening-crawl")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                ScrollView([], showsIndicators: false) {
                    if !self.model.film.openingCrawl.isEmpty {
                        Text(self.model.film.openingCrawl)
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: size.width, height: self.model.film.openingCrawl.heightFrom())
                            .position(x: size.width/2.0, y: (size.height/2.0) - offset)
                            .multilineTextAlignment(.center)
                            .rotation3DEffect(.degrees(20), axis: (x: 1, y: 0, z: 0))
                            .shadow(color: Color.whiteAlpha, radius: 2, x: 0, y: 15.0)
                            .onAppear() {
                                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                                    while(self.model.film.openingCrawl.heightFrom() - offset > (size.height/4.0)) {
                                        self.offset += 1
                                        usleep(100000)
                                    }
                                }
                            }
                    }
                }
                .frame(height: 100.0)
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.white)
                    .frame(height: 1)
            }
            InformationItemView(name: "director", value: self.model.film.director)
            InformationItemView(name: "producer", value: self.model.film.producer)
            InformationItemView(name: "release-date", value: self.model.film.releaseDate)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            BackgroundView(size: geo.size) {
                detail(size: geo.size)
            }
            .task {
                model.detail()
            }
            .alert("Error", isPresented: $model.hasError) {
            } message: {
                Text(model.errorMessage)
            }
            .navigationTitle("Starships")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailView(
            model: FilmDetailViewModel(url: "\(FilmAPIImpl.domain)/1/")
        )
    }
}
