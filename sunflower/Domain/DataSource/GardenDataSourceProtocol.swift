//
//  GardenDataSourceProtocol.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 09/10/25.
//

protocol GardenDataSourceProtocol {
    func addPlant(_ entity: PlantEntity) -> Bool
    func deletePlant(_ entity: PlantEntity) -> Bool
    func updatePlant(_ entity: PlantEntity) -> Bool
    func fetchAllPlants() throws -> [PlantEntity]
}
