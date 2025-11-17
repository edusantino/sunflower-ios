//
//  MyGardenViewModel.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 16/11/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class MyGardenViewModel: ObservableObject {
    @Published private(set) var state: State = .idle
    @Published private(set) var myGardenPlants: [Plant] = []
    @Published private(set) var isLoading: Bool = false

    private let fetchGardenUseCase: FetchGardenUseCase
    
    init(myGardenPlants: [Plant], fetchGardenUseCase: FetchGardenUseCase) {
        self.myGardenPlants = myGardenPlants
        self.fetchGardenUseCase = fetchGardenUseCase
    }
    
    func loadInitialState() async {
        await loadGardenPlants()
    }

    
    // MARK: - Enums
    enum State: Equatable {
        case idle
        case plantRemoved
        case error(String)
    }
    
    enum Action: Equatable {
        case onWatering(Plant)
        case onRemove(Plant)
    }
    
    func send(action: Action) {
        switch action {
        case .onWatering(let plant):
            Task { await updateWatering(plant) }
        case .onRemove(let plant):
            Task { await removePlant(plant) }
        }
    }
    
    func loadGardenPlants() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            myGardenPlants = try await fetchGardenUseCase.execute()
        } catch {
            state = .error("Failed to load garden: \(error.localizedDescription)")
        }
    }
}
