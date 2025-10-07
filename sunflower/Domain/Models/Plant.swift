//
//  Plant.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

import Foundation

struct Plant: Codable, Identifiable {
    var id: String { plantId }
    var isAdded: Bool = false
    var plantId: String
    var name: String
    var description: String
    var growZoneNumber: Int
    var wateringInterval: Int
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case plantId, name, description, growZoneNumber, wateringInterval, imageUrl
    }
}

extension Plant {
    static var mock: Plant {
        Plant(
            plantId: "12", name: "Apple Tree", description: "This is a long description about Apple Tree", growZoneNumber: 12, wateringInterval: 3, imageUrl: ""
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
            imageUrl: self.imageUrl,
            isAdded: self.isAdded
        )
    }
}
