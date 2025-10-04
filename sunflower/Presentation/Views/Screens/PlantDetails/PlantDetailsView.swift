//
//  PlantDetailsView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 29/09/25.
//

import SwiftUI
import Foundation

struct PlantDetailsView: View {
    let plant: Plant
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: URL(string: plant.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipped()
                    } placeholder: {
                        Image("avocado")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipped()
                    }
                    
                    AddButton()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 26/255, green: 28/255, blue: 24/255))
                
                VStack(alignment: .center, spacing: 12) {
                    Text(plant.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 20)
                    
                    Text("Watering needs")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("every 30 days")
                        .font(.body)
                        .foregroundColor(.primary)
                    Text(plant.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
                
            }
            .navigationTitle(plant.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sharePlant()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func sharePlant() {
            let items: [Any] = [
                "Confira esta planta incrível: \(plant.name)",
                URL(string: "https://meuapp.com/plants/\(plant.id)") // se tiver deep link
            ].compactMap { $0 }
            
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                activityVC.popoverPresentationController?.sourceView = rootViewController.view
                activityVC.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                
                rootViewController.present(activityVC, animated: true)
            }
        }
    
}

#Preview {
    PlantDetailsView(plant: .mock)
}
