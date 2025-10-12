//
//  PlantDataSourceProtocol.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

protocol PlantDataSourceProtocol {
    func getPlantDetails(id: String) async throws -> Plant
}
