//
//  PlantLoadingStrategy.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 11/10/25.
//

// MARK: - Loading Strategy Protocol
protocol PlantLoadingStrategy {
    func loadPlants() async throws -> [Plant]
}
