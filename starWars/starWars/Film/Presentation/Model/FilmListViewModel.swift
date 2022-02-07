//
//  FilmListViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import Foundation

class FilmListViewModel: ObservableObject {
    
    let allUseCase = AllFilmUseCase(repository: FilmRepositoryImpl(dataSource: FilmAPIImpl()))
    let filterUserCase = FilterFilmUseCase(repository: FilmRepositoryImpl(dataSource: FilmAPIImpl()))
    let pageUseCase = PageFilmUseCase(repository: FilmRepositoryImpl(dataSource: FilmAPIImpl()))
    @Published var films: FilmListModel = FilmListModel.NullObject
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
            self.pageUseCase.execute(url: self.films.next) {
                switch $0 {
                case .success(let films):
                    self.films.add(model: films)
                case .failure(let error):
                    self.films = FilmListModel.NullObject
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
                self.fetching = false
            }
        }
    }

    private func response(_ result: Result<FilmListModel, UseCaseException>) {
        switch result {
        case .success(let films):
            self.films = films
        case .failure(let error):
            self.films = FilmListModel.NullObject
            self.errorMessage = error.localizedDescription
            self.hasError = true
        }
        self.fetching = false
    }
    
    func containNextPage() -> Bool {
        return !self.films.next.isEmpty
    }

}
