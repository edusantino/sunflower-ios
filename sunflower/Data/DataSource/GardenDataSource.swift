//
//  GardenDataSource.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftData

class GardenDataSource {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchAll() -> [PlantEntity] {
        
    }
    
    func saveEntity(_ entity: PlantEntity) {
        modelContext.insert(entity)
    }
    
    func deleteEntity(_ entity: PlantEntity) {
        modelContext.delete(entity)
    }
}
