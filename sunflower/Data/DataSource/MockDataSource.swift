//
//  MockDataSource.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

struct MockDataSource: PlantDataSourceProtocol {
    func fetchAll() async throws -> [Plant] {
        return [
            Plant(
                plantId: "123",
                name: "Default",
                description: "Default Description",
                growZoneNumber: 4,
                wateringInterval: 2,
                imageUrl: "No Image"
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
            imageUrl: "No Image"
        )
    }
    
    
}
