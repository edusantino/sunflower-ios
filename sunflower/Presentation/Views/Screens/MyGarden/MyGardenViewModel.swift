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
    
    init(repository: GardenRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchGarden() {
        let result = repository.fetchGarden()
        plants = result
    }
    
    func deletePlant() {
        
    }
    
    func addPlant() {
        
    }
}
