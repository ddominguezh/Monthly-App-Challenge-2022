//
//  StarshipDetailViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import Foundation

class StarshipDetailViewModel: ObservableObject {
    
    let detailUseCase = DetailStarshipUseCase(repository: StarshipRepositoryImpl(dataSource: StarshipAPIImpl()))
    let filmUseCase = DetailFilmUseCase(repository: FilmRepositoryImpl(dataSource: FilmAPIImpl()))
    let peopleUseCase = DetailPeopleUseCase(repository: PeopleRepositoryImpl(dataSource: PeopleAPIImpl()))
    private var url: String
    @Published var starship: StarshipModel = StarshipModel.NullObject
    @Published var films: [FilmModel] = [FilmModel]()
    @Published var pilots: [PeopleModel] = [PeopleModel]()
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
            case .success(let starship):
                self.starship = starship
                self.loadFilms()
                self.loadPilots()
            case .failure(let error):
                self.starship = StarshipModel.NullObject
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
            self.fetching = false
        }
    }
    
    private func loadFilms() {
        self.films = [FilmModel]()
        self.starship.films.forEach {
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
    
    private func loadPilots() {
        self.pilots = [PeopleModel]()
        self.starship.pilots.forEach {
            peopleUseCase.execute(url: $0) {
                switch $0 {
                case .success(let people):
                    self.pilots.append(people)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
            }
        }
    }
}
