//
//  Plant.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

import Foundation

struct Plant: Codable, Identifiable {
    var id: String { plantId }

    var plantId: String
    var name: String
    var description: String
    var growZoneNumber: Int
    var wateringInterval: Int
    var imageUrl: String
    
    init(plantId: String, name: String, description: String, growZoneNumber: Int, wateringInterval: Int = 7, imageUrl: String = "") {
        self.plantId = plantId
        self.name = name
        self.description = description
        self.growZoneNumber = growZoneNumber
        self.wateringInterval = wateringInterval
        self.imageUrl = imageUrl
    }
}

extension Plant {
    static var mock: Plant {
        Plant(
            plantId: "12", name: "Apple Tree", description: "This is a long description about Apple Tree", growZoneNumber: 12
        )
    }
    
    static var mockList: [Plant] {
        [mock, mock, mock]
    }
    
    func toEntity() -> PlantEntity {
        return PlantEntity(
            plantId: self.id,
            name: self.name,
            plantDescription: self.description,
            growZoneNumber: self.growZoneNumber,
            wateringInterval: self.wateringInterval,
            imageUrl: self.imageUrl
        )
    }
}
