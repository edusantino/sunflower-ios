//
//  Plant.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

import Foundation

struct Plant: Codable, Identifiable, Hashable, Equatable {
    var id: String { plantId }
    var isAdded: Bool = false
    var plantId: String
    var name: String
    var description: String
    var growZoneNumber: Int
    var wateringInterval: Int
    var imageUrl: String
    var wateringLevel: WateringLevel = .regular
    var birthDate: Date?
    var lastWateringDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case plantId, name, description, growZoneNumber, wateringInterval, imageUrl, birthDate, lastWateringDate
    }
}

extension Plant {
    static var mock: Plant {
        Plant(
            plantId: "12", name: "Apple Tree", description: "This is a long description about Apple Tree", growZoneNumber: 12, wateringInterval: 3, imageUrl: "", wateringLevel: .warning, birthDate: Date(), lastWateringDate: Date()
        )
    }
    static var mockList: [Plant] {
        [mock, mock, mock]
    }
    
    var lastWatering: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let lastWatering = self.lastWateringDate else {
            return "never watered"
        }
        return formatter.string(from: lastWatering)
    }
    
    var plantedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let birthDate = self.birthDate else {
            return "no data"
        }
        
        return formatter.string(from: birthDate)
    }
    
}

enum WateringLevel: String, Codable, CaseIterable, Equatable, Hashable {
    case regular
    case warning
    case danger
    case newPlant
}

