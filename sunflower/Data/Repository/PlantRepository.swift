//
//  PlantRepository.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

struct PlantRepository: PlantRepositoryProtocol {
    let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchPlants() async throws -> [PlantItem] {
        return try await apiService.getPlants()
    }
}
