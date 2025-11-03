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
            let wateringLevel: WateringLevel
            
            let norm = daysSinceLastWatering(lastWatering: lastWatering) / Double(plant.wateringInterval)
            
            let isNewPlant = daysSinceBirth(birthDate: plant.birthDate!) > 3
            
            if isNewPlant {
                wateringLevel = .newPlant
            } else {
                wateringLevel = switch norm {
                case ..<0.5:
                        .regular
                case 0.5...0.8:
                        .warning
                default:
                        .danger
                }
            }

            return Plant(
                isAdded: plant.isAdded,
                plantId: plant.plantId,
                name: plant.name,
                description: plant.description,
                growZoneNumber: plant.growZoneNumber,
                wateringInterval: plant.wateringInterval,
                imageUrl: plant.imageUrl,
                wateringLevel: wateringLevel,
                birthDate: plant.birthDate,
                lastWateringDate: plant.lastWateringDate
            )
        }
    }
    
    func daysSinceBirth(birthDate: Date) -> Double {
        let currentDay = Date()
        let secondsSinceBirth = currentDay.timeIntervalSince(birthDate)
        let days = secondsSinceBirth / (24 * 60 * 60)
        
        return days
    }
    
    func daysSinceLastWatering(lastWatering: Date) -> Double {
        let currentDate = Date()
        
        let secondsSinceLastWatering = currentDate.timeIntervalSince(lastWatering)
        let days = secondsSinceLastWatering / (60 * 60 * 24)
        
        return days
    }
    
}
