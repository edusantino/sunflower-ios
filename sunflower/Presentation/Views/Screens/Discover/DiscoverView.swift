//
//  DiscoverView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftUI

struct DiscoverView: View {
    let onAddPlant: (Plant) -> ()
    let plants: [Plant]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(plants) { plant in
                    DiscoverItem(onAddItem: { plant in
                        onAddPlant(plant)
                    }, plant: plant)
                }
            }
            .padding()
        }
        .background(Color(red: 26/255, green: 28/255, blue: 24/255))
    }
}

#Preview {
    DiscoverView(onAddPlant: {_ in }, plants: [
        Plant(plantId: "1", name: "Apple Tree", description: "Description 1", growZoneNumber: 12, wateringInterval: 3, imageUrl: "", birthDate: Date(), lastWateringDate: Date()),
        Plant(plantId: "2", name: "Rose Bush", description: "Description 2", growZoneNumber: 12, wateringInterval: 3, imageUrl: "", birthDate: Date(), lastWateringDate: Date()),
        Plant(plantId: "3", name: "Cactus", description: "Description 3", growZoneNumber: 12, wateringInterval: 3, imageUrl: "", birthDate: Date(), lastWateringDate: Date())
    ])
}
