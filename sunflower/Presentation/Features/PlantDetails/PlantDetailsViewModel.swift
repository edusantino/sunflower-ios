//
//  PlantDetailsViewModel.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 09/12/25.
//

import Foundation
import Combine

@MainActor
final class PlantDetailsViewModel: ObservableObject {
    
    private let addPlantUseCase: AddPlantToGardenUseCase
    
    // MARK: - Enums
    enum State: Equatable {
        case idle
        case plantLoaded
        case plantAdded
        case plantRemoved
    }
    
    enum Action {
        case add(Plant)
        case remove
        case load(Plant)
    }
    
    init(addPlantUseCase: AddPlantToGardenUseCase) {
        self.addPlantUseCase = addPlantUseCase
    }
    
    // - MARK: Exposed to VIEW
    func send(_ action: Action) {
        switch action {
        case .add(let plant):
            Task { try await addPlantUseCase.execute(plant: plant) }
        case .load(let plant):
        }
    }
}
