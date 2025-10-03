//
//  DiscoverView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject var viewModel = PlantListViewModel()
    let plants: [Plant]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.plants) { plant in
                    DiscoverItem(plant: plant)
                }
            }
            .padding()
        }
        .background(Color(red: 26/255, green: 28/255, blue: 24/255))
        .task {
            await viewModel.loadPlants()
        }
    }
}

#Preview {
    DiscoverView(plants: [
        Plant(plantId: "1", name: "Apple Tree", description: "Description 1", growZoneNumber: 12),
        Plant(plantId: "2", name: "Rose Bush", description: "Description 2", growZoneNumber: 5),
        Plant(plantId: "3", name: "Cactus", description: "Description 3", growZoneNumber: 9)
    ])
}
