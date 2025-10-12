//
//  PlantDataSourceError.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 11/10/25.
//

import Foundation

// MARK: - Error Handling
enum PlantDataSourceError: LocalizedError {
    case plantNotFound(id: String)
    
    var errorDescription: String? {
        switch self {
        case .plantNotFound(let id):
            return "Plant with ID '\(id)' not found"
        }
    }
}
