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
    
    private var compositionRoot: CompositionRoot!
    
    init() {
        FirebaseApp.configure()
        self.compositionRoot = CompositionRoot()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(
                plantListViewModel: compositionRoot.makePlantListViewModel(),
                myGardenViewModel: compositionRoot.makeMyGardenViewModel(
                    modelContext: sharedModelContainer.mainContext
                )
            )
        }
        .modelContainer(sharedModelContainer)
    }
}
