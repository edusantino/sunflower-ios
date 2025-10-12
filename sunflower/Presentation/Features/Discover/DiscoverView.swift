//
//  DiscoverView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftUI

struct DiscoverView: View {
    let onAddPlant: (Plant) -> Void
    let plants: [Plant]
    
    private var backgroundColor: Color {
        Color(Colors.defaultBackground)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Dimen.columns, spacing: Dimen.spacing) {
                ForEach(plants) { plant in
                    DiscoverItem(onAddItem: onAddPlant, plant: plant)
                }
            }
            .padding(Dimen.padding)
        }
        .background(backgroundColor)
    }
}

#Preview {
    DiscoverView(
        onAddPlant: { _ in },
        plants: [
            Plant(plantId: "1", name: "Apple Tree", description: "Description 1", growZoneNumber: 12, wateringInterval: 3, imageUrl: "", birthDate: Date(), lastWateringDate: Date()),
            Plant(plantId: "2", name: "Rose Bush", description: "Description 2", growZoneNumber: 12, wateringInterval: 3, imageUrl: "", birthDate: Date(), lastWateringDate: Date()),
            Plant(plantId: "3", name: "Cactus", description: "Description 3", growZoneNumber: 12, wateringInterval: 3, imageUrl: "", birthDate: Date(), lastWateringDate: Date())
        ]
    )
}
