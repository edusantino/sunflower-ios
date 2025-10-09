//
//  CompositionRoot.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

import SwiftData

final class CompositionRoot {
    private let configRepository = FirebaseRemoteConfigImpl()
    private let offlineDataSource = OfflineDataSource()
    private let mockDataSource = MockDataSource()

    func makePlantListViewModel() -> PlantListViewModel {
        let plantRepository = PlantRepository(
            remoteConfig: configRepository,
            offlineDataSource: offlineDataSource,
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
