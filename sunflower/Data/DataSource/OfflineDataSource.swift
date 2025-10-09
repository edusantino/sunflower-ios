//
//  PlantDataSource.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftData
import Foundation

struct PlantDataSource: PlantDataSourceProtocol {
    
    func getPlantDetails(id: String) async throws -> Plant { // Mude para String
            let plants = try await fetchFromJSONFile()
            guard let plant = plants.first(where: { $0.id == id }) else {
                throw NSError(domain: "PlantNotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "Plant with id \(id) not found"])
            }
            return plant
        }
    

    func fetchFromJSONFile() async throws -> [Plant] {
        print("📦 Loading data from: JSON File")
        print("🔍 Searching for plants.json in bundle...")
        
        guard let url = Bundle.main.url(forResource: "plants", withExtension: "json") else {
            print("❌ File plants.json NOT found in bundle!")
            if let bundleURLs = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil) {
                print("📁 Files JSON in bundle: \(bundleURLs.map { $0.lastPathComponent })")
            }
            throw URLError(.fileDoesNotExist)
        }
        
        print("✅ File found: \(url.path)")
        
        do {
            let data = try Data(contentsOf: url)
            print("📦 File size: \(data.count) bytes")
            
            // Decode process
            let plants = try JSONDecoder().decode([Plant].self, from: data)
            print("🌱 Number of decoded plants: \(plants.count)")
            return plants
            
        } catch let decodingError as DecodingError {
            print("❌ Error on decodification: \(decodingError)")
            throw decodingError
        } catch {
            print("❌ Other error: \(error)")
            throw error
        }
    }
    
    func fetchFromJSONString(json: String) async throws -> [Plant] {
        print("📦 Loading data from: Firebase")
        do {
            guard let jsonData = json.data(using: .utf8) else {
                throw NSError(domain: "JSONError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert string to Data"])
            }
            
            let plants = try JSONDecoder().decode([Plant].self, from: jsonData)
            print("🌱 Number of decoded plants: \(plants.count)")
            return plants
            
        } catch let decodingError as DecodingError {
            print("❌ Error on decodification: \(decodingError)")
            throw decodingError
        } catch {
            print("❌ Other error: \(error)")
            throw error
        }
    }
}
