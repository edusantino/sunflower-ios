//
//  MockPlantLoader.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 11/10/25.
//

// MARK: - Mock para testes
struct MockPlantLoader: PlantLoadingStrategy {
    let plants: [Plant]
    
    func loadPlants() async throws -> [Plant] {
        return plants
    }
}
