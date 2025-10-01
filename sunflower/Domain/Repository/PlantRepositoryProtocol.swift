//
//  PlantRepositoryProtocol.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

protocol PlantRepositoryProtocol {
    func fetchPlants() async throws -> [PlantItem]
}
