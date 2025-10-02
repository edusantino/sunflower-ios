//
//  GardenRepository.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import UIKit
import SwiftUI

struct GardenRepository: GardenRepositoryProtocol {
    @Environment(\.modelContext) private var modelContext
    
    func fetchGarden() -> [Plant] {
        let dataSource = GardenDataSource(modelContext: modelContext)
        return dataSource.fetchAll().map { $0.toDomain() }
    }
}
