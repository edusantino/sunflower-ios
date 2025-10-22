//
//  sunflowerApp.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 28/09/25.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct sunflowerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PlantEntity.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var showSplash: Bool = true
    private var compositionRoot: CompositionRoot!
    private var coordinator: AppCoordinator
    
    init() {
        FirebaseApp.configure()
        self.compositionRoot = CompositionRoot(modelContainer: sharedModelContainer)
        self.coordinator = AppCoordinator()
    }

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                compositionRoot.makeContentView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
