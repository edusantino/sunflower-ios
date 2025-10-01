//
//  Item.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 30/09/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
