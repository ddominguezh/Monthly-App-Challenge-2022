//
//  PlanetListViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import Foundation

class PlanetListViewModel: ObservableObject {
    
    let allUseCase = AllPlanetUseCase(repository: PlanetRepositoryImpl(dataSource: PlanetAPIImpl()))
    let filterUserCase = FilterPlanetUseCase(repository: PlanetRepositoryImpl(dataSource: PlanetAPIImpl()))
    let pageUseCase = PagePlanetUseCase(repository: PlanetRepositoryImpl(dataSource: PlanetAPIImpl()))
    @Published var planets: PlanetListModel = PlanetListModel.NullObject
    @Published var errorMessage = ""
    @Published var hasError = false
    @Published var fetching = false
    
    func all() {
        self.errorMessage = String.Empty
        self.fetching = true
        allUseCase.execute {
            self.response($0)
        }
    }
    
    func filter(value: String) {
        self.errorMessage = String.Empty
        self.fetching = true
        filterUserCase.execute(value: value) {
            self.response($0)
        }
    }
    
    func next() {
        self.errorMessage = String.Empty
        if self.containNextPage() {
            self.fetching = true
            self.pageUseCase.execute(url: self.planets.next) {
                switch $0 {
                case .success(let planets):
                    self.planets.add(model: planets)
                case .failure(let error):
                    self.planets = PlanetListModel.NullObject
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
                self.fetching = false
            }
        }
    }

    private func response(_ result: Result<PlanetListModel, UseCaseException>) {
        switch result {
        case .success(let planets):
            self.planets = planets
        case .failure(let error):
            self.planets = PlanetListModel.NullObject
            self.errorMessage = error.localizedDescription
            self.hasError = true
        }
        self.fetching = false
    }

    func containNextPage() -> Bool {
        return !self.planets.next.isEmpty
    }

}
