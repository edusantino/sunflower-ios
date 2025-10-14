//
//  PlantDetailsView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 29/09/25.
//

import SwiftUI
import Foundation

struct PlantDetailsView: View {
    @EnvironmentObject private var viewModel: ContentViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    
    @State private var isAdded: Bool = false
    @State private var showToast: Bool = false
    @State private var showSuccessCheck = false
    @State private var showShareSheet = false
    let plant: Plant
    
    // MARK: - Constants
    private enum Constants {
        static let imageHeight: CGFloat = 300
        static let horizontalPadding: CGFloat = 16
        static let contentSpacing: CGFloat = 12
        static let descriptionTopPadding: CGFloat = 8
        static let bottomPadding: CGFloat = 20
        static let topPadding: CGFloat = 20
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                plantImageSection
                plantDetailsSection
            }
        }
        .background(DesignSystem.Colors.background)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { toolbarContent }
        .sheet(isPresented: $showShareSheet) { shareSheet }
        .onChange(of: viewModel.state) { _, newState in
            handleState(newState)
        }
        .overlay(alignment: .top) {
            if showToast {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Planta adicionada!")
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
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
            
            AddButton(isAdded: $isAdded) {
                Task {
                    viewModel.send(.addPlant(plant))
                }
            }
        }
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
    var shareItems: [Any] {
        [
            "Confira esta planta incrível: \(plant.name)",
            URL(string: "https://meuapp.com/plants/\(plant.plantId)") ?? URL(string: "https://meuapp.com")!
        ]
    }
}

private extension PlantDetailsView {
    private func handleState(_ state: ContentViewModel.State) {
        switch state {
        case .plantAdded(_):
            withAnimation {
                isAdded = true
                showToast = true
            }
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                withAnimation {
                    showToast = false
                }
                coordinator.navigateBack()
            }
            viewModel.send(.resetState)
            
        case .error(let message):
            coordinator.showToast("Erro: \(message)")
            
        default:
            break
        }
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
            plant: Plant(
                plantId: "1",
                name: "Apple Tree",
                description: "Uma árvore frutífera que produz maçãs deliciosas. Requer cuidado regular e poda anual para manter sua saúde e produtividade.",
                growZoneNumber: 12,
                wateringInterval: 3,
                imageUrl: "https://upload.wikimedia.org/wikipedia/commons/e/e4/Branch_and_fruit_of_the_Maluma_avocado_cultivar.jpg",
                birthDate: Date(),
                lastWateringDate: Date()
            )
        )
    }
}
