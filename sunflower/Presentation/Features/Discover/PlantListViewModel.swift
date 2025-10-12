//
//  PlantListViewModel.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

import Foundation
import Combine

@MainActor
class PlantListViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let repository: PlantRepositoryProtocol
    
    init(plantRepository: PlantRepositoryProtocol) {
        self.repository = plantRepository
    }
    
    @MainActor
    func loadPlants() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await repository.fetchPlants()
            plants = result
        } catch {
            errorMessage = "Erro ao carregar plantas: \(error.localizedDescription)"
            print(errorMessage ?? "error on fetch")
        }
        isLoading = false
    }
}
