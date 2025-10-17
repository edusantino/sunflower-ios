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
    var birthDate: Date? = Date()
    var lastWateringDate: Date? = Date()
    
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
    
    func needsWatering(_ plant: Plant) -> Bool {
        let today = Date()
        guard let daysSincePlanted = Calendar.current.dateComponents(
            [.day], from: plant.lastWateringDate ?? Date(), to: today).day else { return false }
        return daysSincePlanted > plant.wateringInterval
    }
    
    var nextWatering: String {
        guard let nextDate = Calendar.current.date(byAdding: .day, value: wateringInterval, to: lastWateringDate ?? Date()) else {
            return "Date not available"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: nextDate)
    }
    
    var lastWatering: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: lastWateringDate ?? Date())
    }
    
    var plantedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: birthDate ?? Date())
    }
    
}

enum WateringLevel: String, Codable, CaseIterable, Equatable, Hashable {
    case regular
    case warning
    case danger
}

