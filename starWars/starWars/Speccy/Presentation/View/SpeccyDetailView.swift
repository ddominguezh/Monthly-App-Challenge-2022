//
//  SpeccyDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import SwiftUI

struct SpeccyDetailView: View {
    @StateObject var model: SpeccyDetailViewModel
    
    fileprivate func detail(size: CGSize) -> some View {
        VStack {
            if !model.speccy.name.isEmpty {
                DetailImage(name: model.speccy.name)
            }
            ScrollView {
                self.information()
                if !model.homeworld.name.isEmpty {
                    GridHView(title: "homeworld"){
                        GridCellView(
                            text: model.homeworld.name,
                            detailView: AnyView(PlanetRouter.showDetail(planet: model.homeworld))
                        ).frame(minWidth: size.width / 2, maxWidth: 160)
                    }
                }
                if model.films.count > 0 {
                    GridHView(title: "films"){
                        ForEach(model.films){ item in
                            GridCellView(
                                text: item.title,
                                detailView: AnyView(FilmRouter.showDetail(film: item))
                            ).frame(minWidth: size.width / 2, maxWidth: 160)
                        }
                    }
                }
                if model.peoples.count > 0 {
                    GridHView(title: "peoples"){
                        ForEach(model.peoples){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PeopleRouter.showDetail(people: item))
                            ).frame(width: size.width / 2)
                        }
                    }
                }
            }
        }
        .navigationTitle(model.speccy.name)
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
            InformationItemView(name: "classification", value: self.model.speccy.classification)
            InformationItemView(name: "designation", value: self.model.speccy.designation)
            InformationItemView(name: "average-height", value: self.model.speccy.averageHeight)
            InformationItemView(name: "skin-colors", value: self.model.speccy.skinColors)
            InformationItemView(name: "hair-colors", value: self.model.speccy.hairColors)
            InformationItemView(name: "eye-colors", value: self.model.speccy.eyeColors)
            InformationItemView(name: "average-lifespan", value: self.model.speccy.averageLifespan)
            InformationItemView(name: "language", value: self.model.speccy.language)
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

struct SpeccyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpeccyDetailView(
            model: SpeccyDetailViewModel(url: "\(SpeccyAPIImpl.domain)/1/")
        )
    }
}
