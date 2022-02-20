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
                    Text(LocalizedStringKey(name))
                        .foregroundColor(.white)
                }.padding(16)
            }
            .cornerRadius(16.0)
            .overlay(RoundedRectangle(cornerRadius: 16.0).stroke(Color.whiteAlpha, lineWidth: 3))
        }
    }

    var body: some View {
        GeometryReader { geo in
            NavigationView {
                BackgroundView(size: geo.size) {
                    VStack {
                        Image("title")
                            .resizable()
                            .padding(20)
                            .scaledToFit()
                        LazyVGrid(columns: gridItemLayout, spacing: 16.0) {
                            cell(
                                destination: AnyView(FilmRouter.showList()),
                                name: "films",
                                image: "films"
                            )
                            cell(
                                destination: AnyView(PeopleRouter.showList()),
                                name: "peoples",
                                image: "peoples"
                            )
                            cell(
                                destination: AnyView(PlanetRouter.showList()),
                                name: "planets",
                                image: "planets"
                            )
                            cell(
                                destination: AnyView(SpeccyRouter.showList()),
                                name: "species",
                                image: "species"
                            )
                            cell(
                                destination: AnyView(StarshipRouter.showList()),
                                name: "starships",
                                image: "starships"
                            )
                            cell(
                                destination: AnyView(VehicleRouter.showList()),
                                name: "vehicles",
                                image: "vehicles"
                            )
                        }
                    }
                }
                .navigationTitle(String.Empty)
                .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
