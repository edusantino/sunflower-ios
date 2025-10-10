//
//  MyGardenItem.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI

struct MyGardenItem: View {
    let plant: Plant
    
    // MARK: - Constants
    private enum Constants {
        static let cardWidth: CGFloat = 140
        static let imageHeight: CGFloat = 80
        static let cardHeight: CGFloat = 220
        static let cornerRadius: CGFloat = 8
        static let titleMinHeight: CGFloat = 40
    }
    
    // MARK: - Colors
    private struct Colors {
        static let primaryText = Color(red: 220/255, green: 231/255, blue: 216/255)
        static let cardBackground = Color(red: 64/255, green: 74/255, blue: 56/255)
        static let whiteBackground = Color.white
    }
    
    var body: some View {
        VStack(spacing: 0) {
            plantImage
            plantDetails
        }
        .frame(width: Constants.cardWidth, height: Constants.cardHeight)
        .background(Colors.whiteBackground)
        .cornerRadius(Constants.cornerRadius, corners: [.topRight, .bottomLeft])
        .compositingGroup()
        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - Subviews
    private var plantImage: some View {
        AsyncImage(url: URL(string: plant.imageUrl)) { phase in
            switch phase {
            case .empty:
                placeholderImage
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                placeholderImage
            @unknown default:
                placeholderImage
            }
        }
        .frame(width: Constants.cardWidth, height: Constants.imageHeight)
        .clipped()
        .cornerRadius(Constants.cornerRadius, corners: [.topRight])
    }
    
    private var placeholderImage: some View {
        Image("avocado")
            .resizable()
            .scaledToFill()
            .frame(width: Constants.cardWidth, height: Constants.imageHeight)
    }
    
    private var plantDetails: some View {
        VStack(spacing: 4) {
            Text(plant.name)
                .frame(maxWidth: .infinity, minHeight: Constants.titleMinHeight)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Colors.primaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
            
            detailSection(title: "Planted", value: plant.plantedDate)
            detailSection(title: "Last Watered", value: plant.lastWatering)
            
            Text("water in \(plant.wateringInterval) days.")
                .font(.system(size: 10, weight: .regular))
                .foregroundStyle(Colors.primaryText)
                .padding(.top, 4)
                .padding(.bottom, 10)
        }
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity)
        .background(Colors.cardBackground)
        .cornerRadius(Constants.cornerRadius, corners: [.bottomLeft])
    }
    
    private func detailSection(title: String, value: String) -> some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(Colors.primaryText)
            
            Text(value)
                .font(.system(size: 10, weight: .regular))
                .foregroundStyle(Colors.primaryText)
        }
    }
}

#Preview {
    MyGardenItem(plant: .mock)
        .padding()
        .background(Color.gray.opacity(0.1))
}
