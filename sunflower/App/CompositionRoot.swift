//
//  CompositionRoot.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

import SwiftData
import SwiftUI

final class CompositionRoot {
    private let configRepository: FirebaseRemoteConfigImpl
    private let plantDataSource: PlantDataSource
    private let mockDataSource: MockDataSource
    private let modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.configRepository = FirebaseRemoteConfigImpl()
        self.plantDataSource = PlantDataSource()
        self.mockDataSource = MockDataSource()
        
        // Fetch async sem bloquear a inicialização
        Task { [weak self] in
            let success = await self?.configRepository.fetchConfig() ?? false
            print("📡 Remote Config: \(success ? "SUCCESS" : "FAILED - using defaults")")
        }
    }
    
    // Criar AppCoordinator
    func makeAppCoordinator() -> AppCoordinator {
        return AppCoordinator()
    }
    
    // Criar ViewModel com contexto
    func makeContentViewModel() -> ContentViewModel {
        let modelContext = ModelContext(modelContainer)
        
        let plantRepository = PlantRepository(
            remoteConfig: configRepository,
            plantDataSource: plantDataSource,
            mockDataSource: mockDataSource
        )
        let gardenRepository = GardenRepository(
            gardenDataSource: GardenDataSource(modelContext: modelContext)
        )
        
        let fetchPlantUseCase = FetchPlantsUseCase(repository: plantRepository)
        let fetchGardenUseCase = FetchGardenUseCase(repository: gardenRepository)
        let addPlantUseCase = AddPlantToGardenUseCase(repository: gardenRepository)
        
        return ContentViewModel(
            fetchPlantsUseCase: fetchPlantUseCase,
            fetchGardenUseCase: fetchGardenUseCase,
            addPlantUseCase: addPlantUseCase
        )
    }
    
    func makeContentView() -> some View {
        let coordinator = makeAppCoordinator()
        let viewModel = makeContentViewModel()
        return ContentView(
            viewModel: viewModel,
            coordinator: coordinator
        )
        .environmentObject(coordinator)
        .environmentObject(viewModel)
    }
}
