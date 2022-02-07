//
//  VehicleListViewModel.swift
//  starWars
//
//  Created by Diego Alberto Dominguez Herreros on 5/2/22.
//

import Foundation

class VehicleListViewModel: ObservableObject {
    
    let allUseCase = AllVehicleUseCase(repository: VehicleRepositoryImpl(dataSource: VehicleAPIImpl()))
    let filterUserCase = FilterVehicleUseCase(repository: VehicleRepositoryImpl(dataSource: VehicleAPIImpl()))
    let pageUseCase = PageVehicleUseCase(repository: VehicleRepositoryImpl(dataSource: VehicleAPIImpl()))
    @Published var vehicles: VehicleListModel = VehicleListModel.NullObject
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
            self.pageUseCase.execute(url: self.vehicles.next) {
                switch $0 {
                case .success(let vehicles):
                    self.vehicles.add(model: vehicles)
                case .failure(let error):
                    self.vehicles = VehicleListModel.NullObject
                    self.errorMessage = error.localizedDescription
                    self.hasError = true
                }
                self.fetching = false
            }
        }
    }

    private func response(_ result: Result<VehicleListModel, UseCaseException>) {
        switch result {
        case .success(let vehicles):
            self.vehicles = vehicles
        case .failure(let error):
            self.vehicles = VehicleListModel.NullObject
            self.errorMessage = error.localizedDescription
            self.hasError = true
        }
        self.fetching = false
    }
    
    func containNextPage() -> Bool {
        return !self.vehicles.next.isEmpty
    }

}
