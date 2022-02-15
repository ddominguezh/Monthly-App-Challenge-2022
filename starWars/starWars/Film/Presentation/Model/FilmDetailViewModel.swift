//
//  FilmDetailViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import Foundation

class FilmDetailViewModel: ObservableObject {
    
    let detailUseCase = DetailFilmUseCase(repository: FilmRepositoryImpl(dataSource: FilmAPIImpl()))
    let planetUseCase = DetailPlanetUseCase(repository: PlanetRepositoryImpl(dataSource: PlanetAPIImpl()))
    let peopleUseCase = DetailPeopleUseCase(repository: PeopleRepositoryImpl(dataSource: PeopleAPIImpl()))
    let speccyUseCase = DetailSpeccyUseCase(repository: SpeccyRepositoryImpl(dataSource: SpeccyAPIImpl()))
    let vehicleUseCase = DetailVehicleUseCase(repository: VehicleRepositoryImpl(dataSource: VehicleAPIImpl()))
    let starshipUseCase = DetailStarshipUseCase(repository: StarshipRepositoryImpl(dataSource: StarshipAPIImpl()))
    private var url: String
    @Published var film: FilmModel = FilmModel.NullObject
    @Published var planets: [PlanetModel] = [PlanetModel]()
    @Published var characeters: [PeopleModel] = [PeopleModel]()
    @Published var species: [SpeccyModel] = [SpeccyModel]()
    @Published var vehicles: [VehicleModel] = [VehicleModel]()
    @Published var starships: [StarshipModel] = [StarshipModel]()
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
            case .success(let film):
                self.film = film
                self.loadPlanets()
                self.loadCharaceters()
                self.loadSpecies()
                self.loadVehicles()
                self.loadStarships()
            case .failure(let error):
                self.film = FilmModel.NullObject
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
            self.fetching = false
        }
    }
    
    private func loadPlanets() {
        self.planets = [PlanetModel]()
        self.film.planets.forEach {
            planetUseCase.execute(url: $0) {
                switch $0 {
                case .success(let planet):
                    self.planets.append(planet)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
            }
        }
    }
    
    private func loadCharaceters() {
        self.characeters = [PeopleModel]()
        self.film.characters.forEach {
            peopleUseCase.execute(url: $0) {
                switch $0 {
                case .success(let people):
                    self.characeters.append(people)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
            }
        }
    }
    
    private func loadSpecies() {
        self.species = [SpeccyModel]()
        self.film.species.forEach {
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
        self.film.vehicles.forEach {
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
        self.film.starships.forEach {
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
}
