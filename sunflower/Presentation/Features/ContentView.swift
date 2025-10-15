//
//  ContentView.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel
    @StateObject private var coordinator: AppCoordinator
        
    init(viewModel: ContentViewModel,
         coordinator: AppCoordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            VStack(spacing: 0) {
                headerView
                tabBarView
                tabContentView
            }
            .onAppear {
                Task { await viewModel.loadInitialData() }
            }
            .onChange(of: viewModel.state) { _, newState in
                reactToStateChanges(newState)
            }
            .navigationDestination(for: AppCoordinator.Route.self) { route in
                switch route {
                case .garden:
                    MyGardenView(plants: viewModel.availablePlants)
                        .environmentObject(viewModel)
                        .environmentObject(coordinator)
                    
                case .discover:
                    DiscoverView(plants: viewModel.availablePlants)
                        .environmentObject(viewModel)
                        .environmentObject(coordinator)
                    
                case .plantDetails(let plant):
                    PlantDetailsView(plant: plant)
                        .environmentObject(viewModel)
                        .environmentObject(coordinator)
                }
            }
        }
    }
}

// MARK: - Subviews
private extension ContentView {
    var headerView: some View {
        HStack {
            Spacer()
            Text("My Garden")
                .font(DesignSystem.Fonts.title)
                .foregroundColor(DesignSystem.Colors.primaryText)
            Spacer()
            
            Button(action: { viewModel.send(.showFilters) }) {
                Image(systemName: "line.horizontal.3.decrease")
                    .font(DesignSystem.Fonts.icon)
                    .foregroundColor(DesignSystem.Colors.primaryText)
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.large)
        .padding(.top, DesignSystem.Spacing.topSafeArea)
        .padding(.bottom, DesignSystem.Spacing.medium)
        .background(DesignSystem.Colors.background)
    }
    
    var tabBarView: some View {
        HStack(spacing: 0) {
            ForEach(ContentViewModel.Tab.allCases) { tab in
                TabButton(
                    title: tab.title,
                    isSelected: viewModel.selectedTab == tab,
                    iconName: tab.iconName
                ) {
                    viewModel.send(.selectTab(tab))
                }
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.large)
        .background(DesignSystem.Colors.background)
    }
    
    var tabContentView: some View {
        TabView(selection: $viewModel.selectedTab) {
            myGardenTab
                .tag(ContentViewModel.Tab.myGarden)
            
            discoverTab
                .tag(ContentViewModel.Tab.discover)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedTab)
        .ignoresSafeArea()
    }
    
    var myGardenTab: some View {
        Group {
            if viewModel.myGardenPlants.isEmpty {
                VStack {
                    EmptyGardenView(onAddClick: {
                        viewModel.send(.selectTab(.discover))
                    })
                }
            } else {
                MyGardenView(plants: viewModel.myGardenPlants)
            }
        }
    }
    
    var discoverTab: some View {
        DiscoverView(plants: viewModel.availablePlants)
    }
}

// MARK: - State Reaction
private extension ContentView {
    func reactToStateChanges(_ state: ContentViewModel.State) {
        switch state {
        case .idle:
            break
        case .plantAdded(let plant):
            coordinator.showToast("🌱 \(plant.name) added to your garden!")
        case .navigateToPlantDetails(let plant):
            coordinator.navigateToPlantDetails(plant)
        case .showFilters:
            coordinator.showSheet(.filters)
        case .error(let message):
            coordinator.showAlert(title: "Error", message: message)
        }
    }
}
