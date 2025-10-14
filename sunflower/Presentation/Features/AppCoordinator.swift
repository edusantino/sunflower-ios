//
//  AppCoordinator.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 13/10/25.
//

import Foundation
import Combine
import SwiftUI
import os

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var presentedSheet: Sheet?
    @Published var alert: AlertItem?
    @Published var toast: ToastItem?
    @Published var toastMessage: String?
    
    private let logger = Logger(subsystem: "GardenApp", category: "AppCoordinator")
    
    // MARK: - Navigation
    func navigateToPlantDetails(_ plant: Plant) {
        navigationPath.append(Route.plantDetails(plant))
        logger.info("🌱 Navigating to plant details: \(plant.name)")
    }
    
    func navigateBack() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    // MARK: - UI Feedback
    func showAlert(title: String, message: String) {
        alert = AlertItem(title: title, message: message)
    }
    
    func showToast(_ message: String, duration: Double = 3.0) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.toastMessage = nil
        }
    }
    
    func showSheet(_ sheet: Sheet) {
        presentedSheet = sheet
    }
    
    func dismissSheet() {
        presentedSheet = nil
    }
}

// MARK: - Routing Types
extension AppCoordinator {
    enum Route: Hashable {
        case garden
        case discover
        case plantDetails(Plant)
    }
    
    enum Sheet: Identifiable {
        case filters
        case share(Plant)
        
        var id: String {
            switch self {
            case .filters: return "filters"
            case .share(let plant): return "share_\(plant.plantId)"
            }
        }
    }
    
    struct AlertItem: Identifiable {
        let id = UUID()
        let title: String
        let message: String
    }
    
    struct ToastItem: Identifiable {
        let id = UUID()
        let message: String
        let duration: Double
    }
}
