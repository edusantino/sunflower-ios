//
//  GardenRepository.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 01/10/25.
//

struct GardenRepository: GardenRepositoryProtocol {
    private let dataSource: GardenDataSource
    
    init(dataSource: GardenDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchGarden() -> [Plant] {
        return dataSource.fetchAll().map { $0.toDomain() }
    }
}
