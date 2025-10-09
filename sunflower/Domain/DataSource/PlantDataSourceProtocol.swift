//
//  PlantDataSourceProtocol.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

protocol PlantDataSourceProtocol {
    func fetchAll() async throws -> [Plant]
    func getPlantDetails(id: String) async throws -> Plant
}
