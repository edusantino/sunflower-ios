//
//  PlantMapper.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 09/10/25.
//

struct PlantMapper {
    static func toDomain(entity: PlantEntity) -> Plant {
        return Plant(
            plantId: entity.plantId,
            name: entity.name,
            description: entity.plantDescription,
            growZoneNumber: entity.growZoneNumber,
            wateringInterval: entity.wateringInterval,
            imageUrl: entity.imageUrl
        )
    }
    
    static func toEntity(model: Plant) -> PlantEntity {
        return PlantEntity(
            plantId: model.plantId,
            name: model.name,
            plantDescription: model.description,
            growZoneNumber: model.growZoneNumber
        )
    }
}
