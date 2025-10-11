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
    
    // MARK: - Constants
    private enum Constants {
        static let columns = [GridItem(.flexible()), GridItem(.flexible())]
        static let spacing: CGFloat = 12
        static let padding: CGFloat = 16
    }
    
    private var backgroundColor: Color {
        Color(red: 26/255, green: 28/255, blue: 24/255)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Constants.columns, spacing: Constants.spacing) {
                ForEach(plants) { plant in
                    DiscoverItem(onAddItem: onAddPlant, plant: plant)
                }
            }
            .padding(Constants.padding)
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
