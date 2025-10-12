//
//  FirebasePlantLoader.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 11/10/25.
//

import OSLog
import Foundation

// MARK: - Firebase/String Loader
struct FirebasePlantLoader: PlantLoadingStrategy {
    private let jsonString: String
    private let logger = Logger(subsystem: "GardenApp", category: "FirebasePlantLoader")
    
    init(jsonString: String) {
        self.jsonString = jsonString
    }
    
    func loadPlants() async throws -> [Plant] {
        logger.info("🔥 Loading plants from Firebase string")
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            logger.error("❌ Invalid JSON string")
            throw PlantLoadingError.invalidJSONString
        }
        
        do {
            let plants = try JSONDecoder().decode([Plant].self, from: jsonData)
            logger.info("🌱 Successfully decoded \(plants.count) plants from Firebase")
            return plants
        } catch let decodingError as DecodingError {
            logger.error("❌ Firebase decoding failed: \(decodingError.localizedDescription)")
            throw PlantLoadingError.decodingFailed(decodingError)
        }
    }
}
