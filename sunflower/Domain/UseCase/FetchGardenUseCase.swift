//
//  FetchGardenUseCase.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 13/10/25.
//

import Foundation

struct FetchGardenUseCase {
    private let repository: GardenRepository
    
    init(repository: GardenRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Plant] {
        let plants = try repository.fetchGarden()
        
        return plants.map { plant in
            guard let lastWatering = plant.lastWateringDate else {
                return plant
            }

            return Plant(
                isAdded: plant.isAdded,
                plantId: plant.plantId,
                name: plant.name,
                description: plant.description,
                growZoneNumber: plant.growZoneNumber,
                wateringInterval: plant.wateringInterval,
                imageUrl: plant.imageUrl,
                wateringLevel: plant.wateringLevel,
                birthDate: plant.birthDate,
                lastWateringDate: plant.lastWateringDate
            )
        }
    }
}
