//
//  PlantRepository.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

struct PlantRepository: PlantRepositoryProtocol {
    let remoteConfig: ConfigRepository
    let plantDataSource: PlantDataSource
    let mockDataSource: MockDataSource
    
    init(remoteConfig: ConfigRepository, plantDataSource: PlantDataSource, mockDataSource: MockDataSource) {
        self.remoteConfig = remoteConfig
        self.plantDataSource = plantDataSource
        self.mockDataSource = mockDataSource
    }
    
    func fetchPlants() async throws -> [Plant] {
        let result = remoteConfig.getString(forKey: "plant_discover")
        if !result.isEmpty {
            do {
                let plants = try await plantDataSource.fetchFromJSONString(json: result)
                return plants
            } catch {
                print("Failed to fetch from JSON string: \(error)")
            }
        }
        do {
            let plants = try await plantDataSource.fetchFromJSONFile()
            return plants
        } catch {
            print("Failed to fetch from JSON file: \(error)")
        }
        // Last try: MockData
        return try await mockDataSource.fetchAll()
    }
}
