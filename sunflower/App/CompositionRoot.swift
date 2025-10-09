//
//  CompositionRoot.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

final class CompositionRoot {
    private let configRepository = FirebaseRemoteConfigImpl()
    private let offlineDataSource = OfflineDataSource()
    private let mockDataSource = MockDataSource()

    private lazy var plantRepository = PlantRepository(
        remoteConfig: configRepository,
        offlineDataSource: offlineDataSource,
        mockDataSource: mockDataSource
    )

    func makePlantListViewModel() -> PlantListViewModel {
        PlantListViewModel(plantRepository: plantRepository)
    }
}
