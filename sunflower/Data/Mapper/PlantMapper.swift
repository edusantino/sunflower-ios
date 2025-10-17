//
//  PlantMapper.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 09/10/25.
//

import Foundation

struct PlantMapper {
    static func toDomain(entity: PlantEntity) -> Plant {
        return Plant(
            isAdded: entity.isAdded,
            plantId: entity.plantId,
            name: entity.name,
            description: entity.plantDescription,
            growZoneNumber: entity.growZoneNumber,
            wateringInterval: entity.wateringInterval,
            imageUrl: entity.imageUrl,
            wateringLevel: WateringLevel(rawValue: entity.wateringLevel) ?? .regular,
            birthDate: entity.birthDate,
            lastWateringDate: entity.lastWateringDate
        )
    }
    
    static func toEntity(model: Plant) -> PlantEntity {
        return PlantEntity(
            plantId: model.plantId,
            name: model.name,
            plantDescription: model.description,
            growZoneNumber: model.growZoneNumber,
            wateringInterval: model.wateringInterval,
            imageUrl: model.imageUrl,
            isAdded: model.isAdded,
            birthDate: model.birthDate,
            lastWateringDate: model.lastWateringDate,
            wateringLevel: model.wateringLevel.rawValue
        )
    }
}
