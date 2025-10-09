//
//  FirebaseRemoteConfigImpl.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

import Foundation
import FirebaseRemoteConfig

final class FirebaseRemoteConfigImpl: ConfigRepository {
    private let remoteConfig: RemoteConfig

    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        
        // Configura parâmetros padrões, se quiser
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 3600 // 1 hora entre fetches
        remoteConfig.configSettings = settings
    }
    
    func fetchConfig() async -> Bool {
        do {
            // Fetch remoto e ativa os valores
            try await remoteConfig.fetchAndActivate()
            return true
        } catch {
            print("❌ Firebase RemoteConfig fetch failed: \(error.localizedDescription)")
            return false
        }
    }
    
    func getString(forKey key: String) -> String {
        remoteConfig.configValue(forKey: key).stringValue
    }
    
    func getBool(forKey key: String) -> Bool {
        remoteConfig.configValue(forKey: key).boolValue
    }
    
    func getFeatureFlag(_ feature: String) -> Bool {
        remoteConfig.configValue(forKey: "feature_\(feature)").boolValue
    }
}
