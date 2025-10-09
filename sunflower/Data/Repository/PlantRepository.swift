//
//  PlantRepository.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

struct PlantRepository: PlantRepositoryProtocol {
    let remoteConfig: ConfigRepository
    let offlineDataSource: OfflineDataSource
    let mockDataSource: MockDataSource
    
    init(remoteConfig: ConfigRepository, offlineDataSource: OfflineDataSource, mockDataSource: MockDataSource) {
        self.remoteConfig = remoteConfig
        self.offlineDataSource = offlineDataSource
        self.mockDataSource = mockDataSource
    }
    
    func fetchPlants() async throws -> [Plant] {
        do {
            let plants = remoteConfig.getString(forKey: "plant_discover")
            return true
        } catch {
            println
        }
    }
}
