//
//  FetchPlantsUseCase.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

import Foundation

struct FetchPlantsUseCase {
    private let repository: PlantRepositoryProtocol
    
    nonisolated init(repository: PlantRepositoryProtocol = PlantRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [Plant] {
        return try await repository.fetchPlants()
    }
}
