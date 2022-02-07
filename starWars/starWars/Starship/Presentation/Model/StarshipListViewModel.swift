//
//  StarshipListViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import Foundation

class StarshipListViewModel: ObservableObject {
    
    let allUseCase = AllStarshipUseCase(repository: StarshipRepositoryImpl(dataSource: StarshipAPIImpl()))
    let filterUserCase = FilterStarshipUseCase(repository: StarshipRepositoryImpl(dataSource: StarshipAPIImpl()))
    let pageUseCase = PageStarshipUseCase(repository: StarshipRepositoryImpl(dataSource: StarshipAPIImpl()))
    @Published var starships: StarshipListModel = StarshipListModel.NullObject
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
            self.pageUseCase.execute(url: self.starships.next) {
                switch $0 {
                case .success(let starships):
                    self.starships.add(model: starships)
                case .failure(let error):
                    self.starships = StarshipListModel.NullObject
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
                self.fetching = false
            }
        }
    }

    private func response(_ result: Result<StarshipListModel, UseCaseException>) {
        switch result {
        case .success(let starships):
            self.starships = starships
        case .failure(let error):
            self.starships = StarshipListModel.NullObject
            self.errorMessage = error.localizedDescription
            self.hasError = true
        }
        self.fetching = false
    }
    
    func containNextPage() -> Bool {
        return !self.starships.next.isEmpty
    }

}
