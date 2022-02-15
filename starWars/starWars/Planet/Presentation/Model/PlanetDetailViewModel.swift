//
//  PlanetDetailViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import Foundation

class PlanetDetailViewModel: ObservableObject {
    
    let detailUseCase = DetailPlanetUseCase(repository: PlanetRepositoryImpl(dataSource: PlanetAPIImpl()))
    let filmUseCase = DetailFilmUseCase(repository: FilmRepositoryImpl(dataSource: FilmAPIImpl()))
    let peopleUseCase = DetailPeopleUseCase(repository: PeopleRepositoryImpl(dataSource: PeopleAPIImpl()))
    private var url: String
    @Published var planet: PlanetModel = PlanetModel.NullObject
    @Published var films: [FilmModel] = [FilmModel]()
    @Published var residents: [PeopleModel] = [PeopleModel]()
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
            case .success(let planet):
                self.planet = planet
                self.loadFilms()
                self.loadResidents()
            case .failure(let error):
                self.planet = PlanetModel.NullObject
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
            self.fetching = false
        }
    }
    
    private func loadFilms() {
        self.films = [FilmModel]()
        self.planet.films.forEach {
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
    
    private func loadResidents() {
        self.residents = [PeopleModel]()
        self.planet.residents.forEach {
            peopleUseCase.execute(url: $0) {
                switch $0 {
                case .success(let people):
                    self.residents.append(people)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
            }
        }
    }
}
