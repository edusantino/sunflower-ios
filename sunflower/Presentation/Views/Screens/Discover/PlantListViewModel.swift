//
//  PlantListViewModel.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

import Foundation
import Combine

@MainActor
class PlantViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let fetchPlantsUseCase: FetchPlantsUseCase
    
    init(fetchPlantsUseCase: FetchPlantsUseCase) {
        self.fetchPlantsUseCase = fetchPlantsUseCase
    }
    
    func loadPlants() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await fetchPlantsUseCase.execute()
            plants = result
        } catch {
            errorMessage = "Erro ao carregar plantas: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
