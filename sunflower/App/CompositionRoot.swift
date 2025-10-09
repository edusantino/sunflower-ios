//
//  CompositionRoot.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

import SwiftData

final class CompositionRoot {
    private let configRepository: FirebaseRemoteConfigImpl
    private let plantDataSource = PlantDataSource()
    private let mockDataSource = MockDataSource()

    init() {
        self.configRepository = FirebaseRemoteConfigImpl()
        // Fetch async sem bloquear a inicialização
        Task { [weak self] in
            let success = await self?.configRepository.fetchConfig() ?? false
            print("📡 Remote Config: \(success ? "SUCCESS" : "FAILED - using defaults")")
        }
    }

    func makePlantListViewModel() -> PlantListViewModel {
        let plantRepository = PlantRepository(
            remoteConfig: configRepository,
            plantDataSource: plantDataSource,
            mockDataSource: mockDataSource
        )
        return PlantListViewModel(plantRepository: plantRepository)
    }

    func makeMyGardenViewModel(modelContext: ModelContext) -> MyGardenViewModel {
        let gardenDataSource = GardenDataSource(modelContext: modelContext)
        let gardenRepository = GardenRepository(gardenDataSource: gardenDataSource)
        return MyGardenViewModel(repository: gardenRepository)
    }

}
