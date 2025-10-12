//
//  JSONPlantLoader.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 11/10/25.
//

import OSLog
import Foundation

// MARK: - JSON File Loader
struct JSONPlantLoader: PlantLoadingStrategy {
    private let logger = Logger(subsystem: "GardenApp", category: "JSONPlantLoader")
    private let fileName: String
    
    init(fileName: String = "plants") {
        self.fileName = fileName
    }
    
    func loadPlants() async throws -> [Plant] {
        logger.info("📦 Loading plants from JSON file: \(self.fileName)")
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            logger.error("❌ JSON file not found: \(self.fileName).json")
            throw PlantLoadingError.fileNotFound(fileName: fileName)
        }
        
        do {
            let data = try Data(contentsOf: url)
            logger.debug("📦 File size: \(data.count) bytes")
            
            let plants = try JSONDecoder().decode([Plant].self, from: data)
            logger.info("🌱 Successfully decoded \(plants.count) plants")
            return plants
            
        } catch let decodingError as DecodingError {
            logger.error("❌ Decoding failed: \(decodingError.localizedDescription)")
            throw PlantLoadingError.decodingFailed(decodingError)
        } catch {
            logger.error("❌ File loading failed: \(error.localizedDescription)")
            throw PlantLoadingError.fileLoadFailed(error)
        }
    }
}
