//
//  ContentView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    
    private let gridItemLayout = [GridItem(.fixed(150)), GridItem(.fixed(150))]
    
    fileprivate func cell(destination: AnyView, name: String, image: String) -> some View {
        NavigationLink(destination: destination) {
            ZStack {
                Rectangle()
                    .background(Color.blackAlpha)
                    .foregroundColor(.clear)
                VStack{
                    Image(image)
                    Spacer()
                    Text(name)
                        .foregroundColor(.white)
                }.padding(16)
            }
            .cornerRadius(16.0)
        }
    }

    var body: some View {
        GeometryReader { geo in
            NavigationView {
                BackgroundView(size: geo.size) {
                    LazyVGrid(columns: gridItemLayout, spacing: 16.0) {
                        cell(
                            destination: AnyView(FilmRouter.showList()),
                            name: "Films",
                            image: "films"
                        )
                        cell(
                            destination: AnyView(PeopleRouter.showList()),
                            name: "Peoples",
                            image: "peoples"
                        )
                        cell(
                            destination: AnyView(PlanetRouter.showList()),
                            name: "Planets",
                            image: "planets"
                        )
                        cell(
                            destination: AnyView(SpeccyRouter.showList()),
                            name: "Species",
                            image: "species"
                        )
                        cell(
                            destination: AnyView(StarshipRouter.showList()),
                            name: "Starships",
                            image: "starships"
                        )
                        cell(
                            destination: AnyView(VehicleRouter.showList()),
                            name: "Vehicles",
                            image: "vehicles"
                        )
                    }
                }
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
