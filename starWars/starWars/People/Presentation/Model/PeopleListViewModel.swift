//
//  PeopleListViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 4/2/22.
//

import Foundation

class PeopleListViewModel: ObservableObject {
    
    let allUseCase = AllPeopleUseCase(repository: PeopleRepositoryImpl(dataSource: PeopleAPIImpl()))
    let filterUserCase = FilterPeopleUseCase(repository: PeopleRepositoryImpl(dataSource: PeopleAPIImpl()))
    let pageUseCase = PagePeopleUseCase(repository: PeopleRepositoryImpl(dataSource: PeopleAPIImpl()))
    @Published var peoples: PeopleListModel = PeopleListModel.NullObject
    @Published var errorMessage = String.Empty
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
            self.pageUseCase.execute(url: self.peoples.next) {
                switch $0 {
                case .success(let peoples):
                    self.peoples.add(model: peoples)
                case .failure(let error):
                    self.peoples = PeopleListModel.NullObject
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
                self.fetching = false
            }
        }
    }

    private func response(_ result: Result<PeopleListModel, UseCaseException>) {
        switch result {
        case .success(let peoples):
            self.peoples = peoples
        case .failure(let error):
            self.peoples = PeopleListModel.NullObject
            self.errorMessage = error.localizedDescription
            self.hasError = true
        }
        self.fetching = false
    }
    
    func containNextPage() -> Bool {
        return !self.peoples.next.isEmpty
    }

}
