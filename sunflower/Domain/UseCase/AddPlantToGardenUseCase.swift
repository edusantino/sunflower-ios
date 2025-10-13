//
//  AddPlantToGardenUseCase.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 13/10/25.
//

struct AddPlantToGardenUseCase {
    private let repository: GardenRepositoryProtocol
    
    init(repository: GardenRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(plant: Plant) async throws {
        return try repository.addPlant(plant: plant)
    }
}
