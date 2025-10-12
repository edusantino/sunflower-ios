//
//  PlantDetailsView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 29/09/25.
//

import SwiftUI
import Foundation

struct PlantDetailsView: View {
    let onAddPlant: (Plant) -> Void
    let plant: Plant
    @Environment(\.dismiss) private var dismiss
    @State private var showShareSheet = false
    
    // MARK: - Constants
    private enum Constants {
        static let imageHeight: CGFloat = 300
        static let horizontalPadding: CGFloat = 16
        static let contentSpacing: CGFloat = 12
        static let descriptionTopPadding: CGFloat = 8
        static let bottomPadding: CGFloat = 20
        static let topPadding: CGFloat = 20
    }
    
    private var backgroundColor: Color {
        Color(red: 26/255, green: 28/255, blue: 24/255)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                plantImageSection
                plantDetailsSection
            }
        }
        .background(backgroundColor)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { toolbarContent }
        .sheet(isPresented: $showShareSheet) { shareSheet }
    }
}

// MARK: - Subviews
private extension PlantDetailsView {
    var plantImageSection: some View {
        ZStack(alignment: .bottomTrailing) {
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
            .frame(maxWidth: .infinity, maxHeight: Constants.imageHeight)
            .clipped()
            
            AddButton(isAdded: plant.isAdded, onTap: addPlant)
                .padding(16)
        }
        .frame(maxWidth: .infinity, maxHeight: Constants.imageHeight)
    }
    
    var placeholderImage: some View {
        Image("avocado")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: Constants.imageHeight)
            .clipped()
    }
    
    var plantDetailsSection: some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            Text(plant.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, Constants.topPadding)
            
            wateringInfoSection
            
            Text(plant.description)
                .font(.body)
                .foregroundColor(.white)
                .padding(.top, Constants.descriptionTopPadding)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.bottom, Constants.bottomPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var wateringInfoSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Watering needs")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("every \(plant.wateringInterval) days")
                .font(.body)
                .foregroundColor(.white)
        }
    }
    
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { showShareSheet = true }) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.white)
            }
        }
    }
    
    var shareSheet: some View {
        ShareSheet(activityItems: shareItems)
    }
}

// MARK: - Private Methods
private extension PlantDetailsView {
    func addPlant() {
        var updatedPlant = plant
        updatedPlant.isAdded = true
        onAddPlant(updatedPlant)
    }
    
    var shareItems: [Any] {
        [
            "Confira esta planta incrível: \(plant.name)",
            URL(string: "https://meuapp.com/plants/\(plant.plantId)") ?? URL(string: "https://meuapp.com")!
        ]
    }
}

// MARK: - Share Sheet Wrapper
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        
        // Config iPad
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            controller.popoverPresentationController?.sourceView = rootViewController.view
            controller.popoverPresentationController?.sourceRect = CGRect(
                x: UIScreen.main.bounds.width / 2,
                y: UIScreen.main.bounds.height / 2,
                width: 0,
                height: 0
            )
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    NavigationView {
        PlantDetailsView(
            onAddPlant: { _ in },
            plant: Plant(
                plantId: "1",
                name: "Apple Tree",
                description: "Uma árvore frutífera que produz maçãs deliciosas. Requer cuidado regular e poda anual para manter sua saúde e produtividade.",
                growZoneNumber: 12,
                wateringInterval: 3,
                imageUrl: "",
                birthDate: Date(),
                lastWateringDate: Date()
            )
        )
    }
}
