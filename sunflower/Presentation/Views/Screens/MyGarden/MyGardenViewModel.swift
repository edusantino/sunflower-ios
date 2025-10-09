//
//  MyGardenViewModel.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import Foundation
import Combine

@MainActor
class MyGardenViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    @Published var isLoading: Bool = false
    
    private let repository: GardenRepositoryProtocol
    
    init(repository: GardenRepositoryProtocol? = nil) {
        if let repository = repository {
            self.repository = repository
        } else {
            self.repository = GardenRepository()
        }
    }
    
    func loadGarden() {
        let result = repository.fetchGarden()
        print("async result: \(result)")
        plants = result
    }
    
    func deletePlant() {
        
    }
    
    func addPlant(plant: Plant) {
        print("viewModel event: added!")

        repository.addPlant(plant: plant)
    }
}
