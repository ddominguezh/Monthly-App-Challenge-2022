//
//  SpeccyDetailViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import Foundation

class SpeccyDetailViewModel: ObservableObject {
    
    let detailUseCase = DetailSpeccyUseCase(repository: SpeccyRepositoryImpl(dataSource: SpeccyAPIImpl()))
    let filmUseCase = DetailFilmUseCase(repository: FilmRepositoryImpl(dataSource: FilmAPIImpl()))
    let peopleUseCase = DetailPeopleUseCase(repository: PeopleRepositoryImpl(dataSource: PeopleAPIImpl()))
    let planetUseCase = DetailPlanetUseCase(repository: PlanetRepositoryImpl(dataSource: PlanetAPIImpl()))
    private var url: String
    @Published var speccy: SpeccyModel = SpeccyModel.NullObject
    @Published var films: [FilmModel] = [FilmModel]()
    @Published var peoples: [PeopleModel] = [PeopleModel]()
    @Published var homeworld: PlanetModel = PlanetModel.NullObject
    @Published var fetching = false
    @Published var errorMessage = ""
    @Published var hasError = false
    
    init(url: String) {
        self.url = url
    }
    
    func detail() {
        self.errorMessage = String.Empty
        self.fetching = true
        detailUseCase.execute(url: self.url) {
            switch $0 {
            case .success(let speccy):
                self.speccy = speccy
                self.loadFilms()
                self.loadPeoples()
                self.loadHomeworld()
            case .failure(let error):
                self.speccy = SpeccyModel.NullObject
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
            self.fetching = false
        }
    }
    
    private func loadFilms() {
        self.films = [FilmModel]()
        self.speccy.films.forEach {
            filmUseCase.execute(url: $0) {
                switch $0 {
                case .success(let film):
                    self.films.append(film)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
            }
        }
    }
    
    private func loadPeoples() {
        self.peoples = [PeopleModel]()
        self.speccy.people.forEach {
            peopleUseCase.execute(url: $0) {
                switch $0 {
                case .success(let people):
                    self.peoples.append(people)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
            }
        }
    }

    private func loadHomeworld() {
        planetUseCase.execute(url: self.speccy.homeworld) {
            switch $0 {
            case .success(let planet):
                self.homeworld = planet
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
        }
    }
}
