//
//  PlantDataSource.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftData
import Foundation
import OSLog

// MARK: - Main Data Source
struct PlantDataSource: PlantDataSourceProtocol {
    private let plantLoader: PlantLoadingStrategy
    private let logger = Logger(subsystem: "GardenApp", category: "PlantDataSource")
    
    // MARK: - Init com Strategy
    init(plantLoader: PlantLoadingStrategy = JSONPlantLoader()) {
        self.plantLoader = plantLoader
    }
    
    // MARK: - Public Methods
    func getPlantDetails(id: String) async throws -> Plant {
        logger.info("🔍 Fetching plant details for ID: \(id)")
        
        let plants = try await plantLoader.loadPlants()
        guard let plant = plants.first(where: { $0.id == id }) else {
            logger.error("❌ Plant not found with ID: \(id)")
            throw PlantDataSourceError.plantNotFound(id: id)
        }
        
        logger.info("✅ Found plant: \(plant.name)")
        return plant
    }
    
    func getPlantList() async throws -> [Plant] {
        logger.info("🔍 Fetching plant list")
        
        let plants = try await plantLoader.loadPlants()
        
        logger.info("✅ Fetching completed!")
        return plants
    }
}

// MARK: - Usage Examples
extension PlantDataSource {
    // Para testes
    static func makeForTesting(plants: [Plant]) -> PlantDataSource {
        let mockLoader = MockPlantLoader(plants: plants)
        return PlantDataSource(plantLoader: mockLoader)
    }
    
    // Para Firebase
    static func makeForFirebase(jsonString: String) -> PlantDataSource {
        let firebaseLoader = FirebasePlantLoader(jsonString: jsonString)
        return PlantDataSource(plantLoader: firebaseLoader)
    }
}
