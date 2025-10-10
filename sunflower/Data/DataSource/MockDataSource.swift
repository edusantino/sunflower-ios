//
//  MockDataSource.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

import Foundation

struct MockDataSource {
    func fetchAll() async throws -> [Plant] {
        print("📦 Loading data from: MockedData")
        return [
            Plant(
                plantId: "123",
                name: "Default",
                description: "Default Description",
                growZoneNumber: 4,
                wateringInterval: 2,
                imageUrl: "No Image",
                birthDate: Date(),
                lastWateringDate: Date()
            )
        ]
    }
    
    func getPlantDetails(id: String) async throws -> Plant {
        return Plant(
            plantId: "123",
            name: "Default",
            description: "Default Description",
            growZoneNumber: 4,
            wateringInterval: 2,
            imageUrl: "No Image",
            birthDate: Date(),
            lastWateringDate: Date()
        )
    }
    
    
}
