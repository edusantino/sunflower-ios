//
//  Plant.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

struct Plant: Codable {
    var plantId: String
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
}

extension Plant {
    static var mock: Plant {
        Plant(
            plantId: "12", name: "Apple Tree", plantDescription: "This is a long description about Apple Tree", growZoneNumber: 12
        )
    }
    
    static var mockList: [Plant] {
        [mock, mock, mock]
    }
}
