//
//  GardenDataSource.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 09/10/25.
//

import SwiftData
import OSLog

struct GardenDataSource: GardenDataSourceProtocol {
    private let modelContext: ModelContext
    private let logger = Logger(subsystem: "GardenApp", category: "GardenDataSource")
    
    // MARK: - Init
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension GardenDataSource {
    func addPlant(_ entity: PlantEntity) throws {
        try saveContext()
        logger.info("✅ Plant added: \(entity.name)")
    }
    
    func deletePlant(_ entity: PlantEntity) throws {
        modelContext.delete(entity)
        try saveContext()
        logger.info("🗑️ Plant deleted: \(entity.name)")
    }
    
    func updatePlant(_ entity: PlantEntity) throws {
        try saveContext()
        logger.info("✏️ Plant updated: \(entity.name)")
    }
    
    func fetchAllPlants() throws -> [PlantEntity] {
        let descriptor = FetchDescriptor<PlantEntity>(
            sortBy: [SortDescriptor(\.name)]
        )
        
        do {
            let plants = try modelContext.fetch(descriptor)
            logger.info("🌱 Fetched \(plants.count) plants")
            return plants
        } catch {
            logger.error("❌ Error fetching plants: \(error.localizedDescription)")
            throw GardenDataSourceError.fetchFailed(error)
        }
    }
}

// MARK: - Private Helpers
private extension GardenDataSource {
    func saveContext() throws {
        guard modelContext.hasChanges else {
            logger.debug("ℹ️ No changes to save")
            return
        }
        
        do {
            try modelContext.save()
        } catch {
            logger.error("❌ Save failed: \(error.localizedDescription)")
            throw GardenDataSourceError.saveFailed(error)
        }
    }
}

extension GardenDataSource {
    enum GardenDataSourceError: LocalizedError {
        case saveFailed(Error)
        case fetchFailed(Error)
        case plantNotFound
        
        var errorDescription: String? {
            switch self {
            case .saveFailed(let error):
                return "Failed to save plant: \(error.localizedDescription)"
            case .fetchFailed(let error):
                return "Failed to fetch plants: \(error.localizedDescription)"
            case .plantNotFound:
                return "Plant not found in database"
            }
        }
    }
}
