//
//  DiscoverItem.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI
import Kingfisher

struct DiscoverItem: View {
    let plant: Plant
    
    // MARK: - Constants
    private enum Constants {
        static let cardWidth: CGFloat = 160
        static let imageHeight: CGFloat = 80
        static let cardHeight: CGFloat = 130
        static let cornerRadius: CGFloat = 8
        static let titleMinHeight: CGFloat = 24
    }
    
    // MARK: - Colors
    private struct Colors {
        static let primaryText = Color(red: 220/255, green: 231/255, blue: 216/255)
        static let cardBackground = Color(red: 64/255, green: 74/255, blue: 56/255)
        static let whiteBackground = Color.white
    }
    
    var body: some View {
        NavigationLink {
            PlantDetailsView(plant: plant)
        } label: {
            VStack(spacing: 0) {
                plantImage
                plantTitle
            }
            .frame(width: Constants.cardWidth, height: Constants.cardHeight)
            .background(Colors.whiteBackground)
            .cornerRadius(Constants.cornerRadius, corners: [.topRight, .bottomLeft])
            .compositingGroup()
        }
    }
    
    // MARK: - Subviews
    private var plantImage: some View {
        KFImage(URL(string: plant.imageUrl))
            .placeholder {
                Image("avocado")
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.cardWidth, height: Constants.imageHeight)
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
            .frame(width: Constants.cardWidth, height: Constants.imageHeight)
            .clipped()
            .cornerRadius(Constants.cornerRadius, corners: [.topRight])
    }
    
    private var plantTitle: some View {
        Text(plant.name)
            .frame(maxWidth: .infinity, minHeight: 50)
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(Color(red: 220/255, green: 231/255, blue: 216/255))
            .background(Color(red: 64/255, green: 74/255, blue: 56/255))
    }
}

#Preview {
    DiscoverItem(plant: .mock)
}
