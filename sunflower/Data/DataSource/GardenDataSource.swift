//
//  GardenDataSource.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 09/10/25.
//

import SwiftData

struct GardenDataSource: GardenDataSourceProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addPlant(_ entity: PlantEntity) -> Bool {
        modelContext.insert(entity)
        
        guard modelContext.hasChanges else {
            return true
        }
        
        do {
            try modelContext.save()
            return true
        } catch {
            print("Error saving entity: \(error)")
            return false
        }
    }
    
    func deletePlant(_ entity: PlantEntity) -> Bool {
        modelContext.delete(entity)
        
        guard modelContext.hasChanges else {
            return true
        }
        
        do {
            try modelContext.save()
            return true
        } catch {
            print("Error deleting entity: \(error)")
            return false
        }
    }
    
    func updatePlant(_ entity: PlantEntity) -> Bool {
        return true
    }
    
    func fetchAllPlants() throws -> [PlantEntity] {
        let descriptor = FetchDescriptor<PlantEntity>()
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("❌ Error fetching plants: \(error)")
            throw error
        }
    }
    
}
