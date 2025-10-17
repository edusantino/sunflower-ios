//
//  MyGardenItem.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI
import Kingfisher

struct MyGardenItem: View {
    @EnvironmentObject private var viewModel: ContentViewModel
    let plant: Plant
    
    var body: some View {
        Button {
             viewModel.send(.showPlantDetails(plant))
        } label: {
            VStack(spacing: 0) {
                plantImage
                plantDetails
            }
            .frame(width: Dimen.cardWidth, height: Dimen.cardHeight)
            .background(
                plant.wateringLevel == .regular ? DesignSystem.Colors.regularLevel
                : plant.wateringLevel == .warning ? DesignSystem.Colors.warningLevel
                : DesignSystem.Colors.dangerLevel
            )
            .cornerRadius(Dimen.cornerRadius, corners: [.topRight, .bottomLeft])
            .compositingGroup()
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Subviews
    private var plantImage: some View {
        KFImage(URL(string: plant.imageUrl))
            .placeholder {
                Image("avocado")
                    .resizable()
                    .scaledToFill()
                    .frame(width: Dimen.cardWidth, height: Dimen.imageHeight)
            }
            .onProgress { receivedSize, totalSize in
                print("Loading progress: \(receivedSize)/\(totalSize)")
            }
            .onSuccess { result in
                print("Image loaded successfully: \(result.source.url?.absoluteString ?? "")")
            }
            .onFailure { error in
                print("Failed to load image: \(error)")
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Dimen.cardWidth, height: Dimen.imageHeight)
            .clipped()
            .cornerRadius(Dimen.cornerRadius, corners: [.topRight])
    }
    
    private var plantDetails: some View {
        VStack(spacing: 4) {
            Text(plant.name)
                .frame(maxWidth: .infinity, minHeight: Dimen.titleMinHeight)
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
        .cornerRadius(Dimen.cornerRadius, corners: [.bottomLeft])
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
