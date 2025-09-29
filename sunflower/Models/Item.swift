//
//  Item.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
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
