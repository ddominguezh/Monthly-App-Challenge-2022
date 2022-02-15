//
//  SpeccyDetailView.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import SwiftUI

struct SpeccyDetailView: View {
    @StateObject var model: SpeccyDetailViewModel
    
    fileprivate func detail() -> some View {
        VStack {
            if !model.speccy.name.isEmpty {
                ImageView(name: model.speccy.name)
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
                if model.peoples.count > 0 {
                    Title("Peoples")
                    GridHView {
                        ForEach(model.peoples){ item in
                            GridCellView(
                                text: item.name,
                                detailView: AnyView(PeopleRouter.showDetail(people: item))
                            )
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
            InformationItemView(name: "Classification", value: self.model.speccy.classification)
            InformationItemView(name: "Designation", value: self.model.speccy.designation)
            InformationItemView(name: "Average Height", value: self.model.speccy.averageHeight)
            InformationItemView(name: "Skin Colors", value: self.model.speccy.skinColors)
            InformationItemView(name: "Hair Colors", value: self.model.speccy.hairColors)
            InformationItemView(name: "Eye Colors", value: self.model.speccy.eyeColors)
            InformationItemView(name: "Average Lifespan", value: self.model.speccy.averageLifespan)
            InformationItemView(name: "Homeworld", value: self.model.speccy.homeworld)
            InformationItemView(name: "Language", value: self.model.speccy.language)
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

struct SpeccyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpeccyDetailView(
            model: SpeccyDetailViewModel(url: "https://swapi.dev/api/species/1/")
        )
    }
}
