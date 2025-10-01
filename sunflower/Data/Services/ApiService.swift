//
//  ApiService.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

import SwiftData
import Foundation

struct ApiService {
    func getPlants() async throws -> [Plant] {
        guard let url = Bundle.main.url(forResource: "plants", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Plant].self, from: data)
    }
}
