//
//  GetPokemonUseCase.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 08/01/26.
//

import Foundation

protocol GetPokemonUseCaseInterface {
  func execute() async -> [PokemonDomainModel]
}

final class GetPokemonUseCase: GetPokemonUseCaseInterface {
  
  private let repository: PokemonRepositoryInterface
  
  init(repository: PokemonRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async -> [PokemonDomainModel] {
    let result = await repository.getPokemonList(limit: 20, offset: 0)
    switch result {
    case .success(let list):
      return list
    case .failure:
      return []
    }
  }
}
