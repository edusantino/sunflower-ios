//
//  PlantLoadingError.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 11/10/25.
//

import Foundation

enum PlantLoadingError: LocalizedError {
    case fileNotFound(fileName: String)
    case fileLoadFailed(Error)
    case decodingFailed(DecodingError)
    case invalidJSONString
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound(let fileName):
            return "File '\(fileName).json' not found in bundle"
        case .fileLoadFailed(let error):
            return "Failed to load file: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "Failed to decode plants: \(error.localizedDescription)"
        case .invalidJSONString:
            return "Invalid JSON string provided"
        }
    }
}
