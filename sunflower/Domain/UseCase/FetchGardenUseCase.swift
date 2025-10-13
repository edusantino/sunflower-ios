//
//  FetchGardenUseCase.swift
//  sunflower
//
//  Created by Eduardo Santino Campos on 13/10/25.
//

struct FetchGardenUseCase {
    private let repository: GardenRepository
    
    init(repository: GardenRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Plant] {
        return try repository.fetchGarden()
    }
    
}
