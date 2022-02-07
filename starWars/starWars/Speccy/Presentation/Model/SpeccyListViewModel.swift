//
//  SpeccyListViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import Foundation

class SpeccyListViewModel: ObservableObject {
    
    let allUseCase = AllSpeccyUseCase(repository: SpeccyRepositoryImpl(dataSource: SpeccyAPIImpl()))
    let filterUserCase = FilterSpeccyUseCase(repository: SpeccyRepositoryImpl(dataSource: SpeccyAPIImpl()))
    let pageUseCase = PageSpeccyUseCase(repository: SpeccyRepositoryImpl(dataSource: SpeccyAPIImpl()))
    @Published var species: SpeccyListModel = SpeccyListModel.NullObject
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
        self.fetching = true
        self.errorMessage = String.Empty
        filterUserCase.execute(value: value) {
            self.response($0)
        }
    }
    
    func next() {
        self.errorMessage = String.Empty
        if self.containNextPage() {
            self.fetching = true
            self.pageUseCase.execute(url: self.species.next) {
                switch $0 {
                case .success(let species):
                    self.species.add(model: species)
                case .failure(let error):
                    self.species = SpeccyListModel.NullObject
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
                self.fetching = false
            }
        }
    }
    
    private func response(_ result: Result<SpeccyListModel, UseCaseException>) {
        switch result {
        case .success(let species):
            self.species = species
        case .failure(let error):
            self.species = SpeccyListModel.NullObject
            self.errorMessage = error.localizedDescription
            self.hasError = true
        }
        self.fetching = false
    }
    
    func containNextPage() -> Bool {
        return !self.species.next.isEmpty
    }
}
