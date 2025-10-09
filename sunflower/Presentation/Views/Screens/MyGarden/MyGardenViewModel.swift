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
    @Published var uiResponse: Bool = false
    
    private let repository: GardenRepositoryProtocol
    
    init(repository: GardenRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadGarden() {
        do {
            let result = try repository.fetchGarden()
            print("async result: \(result)")
            plants = result
        } catch {
            print("Plants not loaded: []")
        }
    }
    
    func deletePlant() {
        
    }
    
    func addPlant(plant: Plant) {
        uiResponse = repository.addPlant(plant: plant)
    }
}
