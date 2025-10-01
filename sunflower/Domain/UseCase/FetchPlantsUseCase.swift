//
//  FetchPlantsUseCase.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

import Foundation

struct FetchPlantsUseCase {
    private let repository: PlantRepositoryProtocol
    
    init(repository: PlantRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [PlantEntity] {
        return try await repository.fetchPlants()
    }
}
