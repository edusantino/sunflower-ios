//
//  GardenView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI
import Foundation

struct GardenView: View {
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
                MyPlantsView()
                    .tag(0)
                
                DiscoverView()
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .ignoresSafeArea()
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: iconName)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .gray)
                
                Rectangle()
                    .fill(isSelected ? Color(red: 157/255, green: 216/255, blue: 117/255) : Color.clear)
                    .frame(height: 2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct MyPlantsView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(0..<6) { _ in
                    MyGardenItem()
                }
            }
            .padding()
        }
        .background(Color(red: 26/255, green: 28/255, blue: 24/255))
    }
}

struct DiscoverView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(0..<12) { _ in
                    PlantItem()
                }
            }
            .padding()
        }
        .background(Color(red: 26/255, green: 28/255, blue: 24/255))
    }
}

#Preview {
    GardenView()
}
