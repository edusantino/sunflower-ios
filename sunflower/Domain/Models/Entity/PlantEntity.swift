//
//  PlantEntity.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 29/09/25.
//

import SwiftData
import Foundation

@Model
final class PlantEntity {
    @Attribute(.unique) var plantId: String
    var name: String
    var plantDescription: String
    var growZoneNumber: Int
    var wateringInterval: Int
    var imageUrl: String
    
    init(plantId: String, name: String, plantDescription: String, growZoneNumber: Int, wateringInterval: Int = 7, imageUrl: String = "") {
            self.plantId = plantId
            self.name = name
            self.plantDescription = plantDescription
            self.growZoneNumber = growZoneNumber
            self.wateringInterval = wateringInterval
            self.imageUrl = imageUrl
    }
    
    /**
     * Determines if the plant should be watered.  Returns true if [since]'s date > date of last
     * watering + watering Interval; false otherwise.
     * */
    func shouldBeWatered(since: Date, lastWateringDate: Date) -> Bool {
            guard let nextWateringDate = Calendar.current.date(
                byAdding: .day,
                value: wateringInterval,
                to: lastWateringDate
            ) else { return false }
            return since > nextWateringDate
        }
}

extension PlantEntity {
    func toDomain() -> Plant {
        return Plant(
            plantId: plantId,
            name: name,
            description: plantDescription,
            growZoneNumber: growZoneNumber,
            imageUrl: imageUrl
        )
    }
}
