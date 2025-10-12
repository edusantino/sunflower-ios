//
//  GardenDataSourceProtocol.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 09/10/25.
//

protocol GardenDataSourceProtocol {
    func addPlant(_ entity: PlantEntity) throws
    func deletePlant(_ entity: PlantEntity) throws
    func updatePlant(_ entity: PlantEntity) throws
    func fetchAllPlants() throws -> [PlantEntity]
}
