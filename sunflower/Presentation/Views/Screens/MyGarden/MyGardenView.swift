//
//  MyGardenView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftUI

struct MyGardenView: View {
    let plants: [Plant]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(plants) { plant in
                    MyGardenItem(plant: plant)
                }
            }
            .padding()
        }
        .background(Color(red: 26/255, green: 28/255, blue: 24/255))
    }
}

#Preview {
    MyGardenView(plants: [
        Plant(plantId: "1", name: "Apple Tree", description: "Description 1", growZoneNumber: 12, wateringInterval: 3, imageUrl: ""),
        Plant(plantId: "2", name: "Rose Bush", description: "Description 2", growZoneNumber: 12, wateringInterval: 3, imageUrl: ""),
        Plant(plantId: "3", name: "Cactus", description: "Description 3", growZoneNumber: 12, wateringInterval: 3, imageUrl: "")
    ])
}
