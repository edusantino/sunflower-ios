//
//  GardenRepositoryProtocol.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

protocol GardenRepositoryProtocol {
    func fetchGarden() -> [Plant]
    func addPlant(plant: Plant)
}
