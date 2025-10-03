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
        // Primeiro, vamos debuggar
        print("🔍 Procurando arquivo plants.json no bundle...")
        
        guard let url = Bundle.main.url(forResource: "plants", withExtension: "json") else {
            print("❌ Arquivo plants.json NÃO encontrado no bundle!")
            // Lista todos os arquivos do bundle para debug
            if let bundleURLs = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil) {
                print("📁 Arquivos JSON no bundle: \(bundleURLs.map { $0.lastPathComponent })")
            }
            throw URLError(.fileDoesNotExist)
        }
        
        print("✅ Arquivo encontrado: \(url.path)")
        
        do {
            let data = try Data(contentsOf: url)
            print("📦 Tamanho do dados: \(data.count) bytes")
            
            // Tenta decodificar
            let plants = try JSONDecoder().decode([Plant].self, from: data)
            print("🌱 Plantas decodificadas: \(plants.count)")
            return plants
            
        } catch let decodingError as DecodingError {
            print("❌ Erro de decodificação: \(decodingError)")
            throw decodingError
        } catch {
            print("❌ Outro erro: \(error)")
            throw error
        }
    }
}
