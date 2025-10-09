//
//  PlantDataSourceProtocol.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

protocol PlantDataSourceProtocol {
    func fetchFromJSONFile() async throws -> [Plant]
    func getPlantDetails(id: String) async throws -> Plant
    func fetchFromJSONString(json: String) async throws -> [Plant]
}
