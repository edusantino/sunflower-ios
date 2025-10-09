//
//  ConfigRepository.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 08/10/25.
//

protocol ConfigRepository {
    func fetchConfig() async -> Bool
    func getString(forKey key: String) -> String
    func getBool(forKey key: String) -> Bool
    func getFeatureFlag(_ feature: String) -> Bool
}
