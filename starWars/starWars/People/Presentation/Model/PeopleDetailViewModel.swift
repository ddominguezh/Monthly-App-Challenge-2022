//
//  PeopleDetailViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import Foundation

class PeopleDetailViewModel: ObservableObject {
    
    let detailUseCase = DetailPeopleUseCase(repository: PeopleRepositoryImpl(dataSource: PeopleAPIImpl()))
    let filmUseCase = DetailFilmUseCase(repository: FilmRepositoryImpl(dataSource: FilmAPIImpl()))
    let speccyUseCase = DetailSpeccyUseCase(repository: SpeccyRepositoryImpl(dataSource: SpeccyAPIImpl()))
    let vehicleUseCase = DetailVehicleUseCase(repository: VehicleRepositoryImpl(dataSource: VehicleAPIImpl()))
    let starshipUseCase = DetailStarshipUseCase(repository: StarshipRepositoryImpl(dataSource: StarshipAPIImpl()))
    let planetUseCase = DetailPlanetUseCase(repository: PlanetRepositoryImpl(dataSource: PlanetAPIImpl()))
    private var url: String
    @Published var people: PeopleModel = PeopleModel.NullObject
    @Published var films: [FilmModel] = [FilmModel]()
    @Published var species: [SpeccyModel] = [SpeccyModel]()
    @Published var vehicles: [VehicleModel] = [VehicleModel]()
    @Published var starships: [StarshipModel] = [StarshipModel]()
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
            case .success(let people):
                self.people = people
                self.loadFilms()
                self.loadSpecies()
                self.loadVehicles()
                self.loadStarships()
                self.loadHomeworld()
            case .failure(let error):
                self.people = PeopleModel.NullObject
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
            self.fetching = false
        }
    }
    
    private func loadFilms() {
        self.films = [FilmModel]()
        self.people.films.forEach {
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
    
    private func loadSpecies() {
        self.species = [SpeccyModel]()
        self.people.species.forEach {
            speccyUseCase.execute(url: $0) {
                switch $0 {
                case .success(let speccy):
                    self.species.append(speccy)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
            }
        }
    }
    
    private func loadVehicles() {
        self.vehicles = [VehicleModel]()
        self.people.vehicles.forEach {
            vehicleUseCase.execute(url: $0) {
                switch $0 {
                case .success(let vehicle):
                    self.vehicles.append(vehicle)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
            }
        }
    }
    
    private func loadStarships() {
        self.starships = [StarshipModel]()
        self.people.starships.forEach {
            starshipUseCase.execute(url: $0) {
                switch $0 {
                case .success(let starship):
                    self.starships.append(starship)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
            }
        }
    }

    private func loadHomeworld() {
        planetUseCase.execute(url: self.people.homeworld) {
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
