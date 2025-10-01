//
//  ContentView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var myGarden: [PlantEntity]

    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("My Garden")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.top, 60)
            .padding(.bottom, 20)
            .background(Color(red: 26/255, green: 28/255, blue: 24/255))
            
            // Custom tabs
            HStack(spacing: 0) {
                TabButton(title: "My Plants", isSelected: selectedTab == 0, iconName: "camera.macro") {
                    selectedTab = 0
                }
                
                TabButton(title: "Discover", isSelected: selectedTab == 1, iconName:
                            "leaf.fill") {
                    selectedTab = 1
                }
            }
            .padding(.horizontal)
            .background(Color(red: 26/255, green: 28/255, blue: 24/255))
            
            // Tab content
            TabView(selection: $selectedTab) {
                if (myGarden.isEmpty) {
                    EmptyGardenView()
                        .tag(0)
                } else {
                    MyPlantsView()
                        .tag(0)
                }
                
                DiscoverView()
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .ignoresSafeArea()
    }

    private func addItem() {
        withAnimation {
            //let newItem = Item(timestamp: Date())
            //modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                //modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PlantEntity.self, inMemory: true)
}


