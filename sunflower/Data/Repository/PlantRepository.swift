//
//  PlantRepository.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

struct PlantRepository: PlantRepositoryProtocol {
    let apiService: ApiService
    
    nonisolated init(apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }
    
    func fetchPlants() async throws -> [Plant] {
        return try await apiService.getPlants()
    }
}
