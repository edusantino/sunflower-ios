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
        let currentDate = Date()
        
        return plants.map { plant in
            let updatedPlant = plant
            
            guard let lastWatering = plant.lastWateringDate else {
                return updatedPlant
            }
            
            let secondsSinceLastWatering = currentDate.timeIntervalSince(lastWatering)
            let daysSinceLastWatering = secondsSinceLastWatering / (60 * 60 * 24)
            
            let progress = daysSinceLastWatering / Double(plant.wateringInterval)
            
            let wateringLevel = switch progress {
            case 0...0.5:
                WateringLevel.regular
            case 0.5...0.8:
                WateringLevel.warning
            default:
                WateringLevel.danger
            }
            
            return Plant(
                isAdded: plant.isAdded,
                plantId: plant.plantId,
                name: plant.name,
                description: plant.description,
                growZoneNumber: plant.growZoneNumber,
                wateringInterval: plant.wateringInterval,
                imageUrl: plant.imageUrl,
                wateringLevel: wateringLevel
            )
        }
    }
    
}
