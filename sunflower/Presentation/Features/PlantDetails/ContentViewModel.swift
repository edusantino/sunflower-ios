//
//  ContentViewModel.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 12/10/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class ContentViewModel: ObservableObject {
    @Published private(set) var state: State = .idle
    @Published var selectedTab: Tab = .myGarden
    @Published private(set) var myGardenPlants: [Plant] = []
    @Published private(set) var availablePlants: [Plant] = []
    
    private let fetchPlantsUseCase: FetchPlantsUseCase
    private let fetchGardenUseCase: FetchGardenUseCase
    private let addPlantUseCase: AddPlantToGardenUseCase
    
    // MARK: - Enums
    enum State: Equatable {
        case idle
        case plantAdded(Plant)
        case navigateToPlantDetails(Plant)
        case showFilters
        case error(String)
    }
    
    enum Action {
        case onAppear
        case selectTab(Tab)
        case loadGarden
        case loadPlants
        case addPlant(Plant)
        case showPlantDetails(Plant)
        case showFilters
        case resetState
    }
    
    enum Tab: CaseIterable, Identifiable {
        case myGarden, discover
        
        var id: String { title }
        var title: String {
            switch self {
            case .myGarden: return "My Plants"
            case .discover: return "Discover"
            }
        }
        var iconName: String {
            switch self {
            case .myGarden: return "camera.macro"
            case .discover: return "leaf.fill"
            }
        }
    }
    
    // MARK: - Init
    init(
        fetchPlantsUseCase: FetchPlantsUseCase,
        fetchGardenUseCase: FetchGardenUseCase,
        addPlantUseCase: AddPlantToGardenUseCase
    ) {
        self.fetchPlantsUseCase = fetchPlantsUseCase
        self.fetchGardenUseCase = fetchGardenUseCase
        self.addPlantUseCase = addPlantUseCase
    }
    
    // MARK: - Public API
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            Task { await loadInitialData() }
        case .selectTab(let tab):
            selectedTab = tab
        case .loadGarden:
            Task { await loadGardenPlants() }
        case .loadPlants:
            Task { await loadAvailablePlants() }
        case .addPlant(let plant):
            Task { await addPlantToGarden(plant) }
        case .showPlantDetails(let plant):
            state = .navigateToPlantDetails(plant)
        case .showFilters:
            state = .showFilters
        case .resetState:
            state = .idle
        }
    }
    
    func loadInitialData() async {
        await loadGardenPlants()
        await loadAvailablePlants()
    }
}

// MARK: - Private Helpers
private extension ContentViewModel {
    func loadGardenPlants() async {
        do {
            myGardenPlants = try await fetchGardenUseCase.execute()
        } catch {
            state = .error("Failed to load garden: \(error.localizedDescription)")
        }
    }
    
    func loadAvailablePlants() async {
        guard availablePlants.isEmpty else { return }
        do {
            availablePlants = try await fetchPlantsUseCase.execute()
        } catch {
            state = .error("Failed to load plants: \(error.localizedDescription)")
        }
    }
    
    func addPlantToGarden(_ plant: Plant) async {
        do {
            try await addPlantUseCase.execute(plant: plant)
            myGardenPlants = try await fetchGardenUseCase.execute() // Refresh local cache
            state = .plantAdded(plant)
            selectedTab = .myGarden
        } catch {
            state = .error("Failed to add plant: \(error.localizedDescription)")
        }
    }
}
