//
//  GardenRepository.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import UIKit
import SwiftUI

struct GardenRepository: GardenRepositoryProtocol {
    let gardenDataSource: GardenDataSourceProtocol
    
    init(gardenDataSource: GardenDataSourceProtocol) {
        self.gardenDataSource = gardenDataSource
    }
    
    func fetchGarden() throws -> [Plant] {
        let entities = try gardenDataSource.fetchAllPlants()
        return entities.map { PlantMapper.toDomain(entity: $0) }
    }
    
    func addPlant(plant: Plant) -> Bool {
        let entity = PlantMapper.toEntity(model: plant)
        return gardenDataSource.addPlant(entity)
    }
}
