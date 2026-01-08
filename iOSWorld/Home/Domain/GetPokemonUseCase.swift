//
//  GetPokemonUseCase.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 08/01/26.
//

import Foundation

protocol GetPokemonUseCaseInterface {
  func execute() async -> [Pokemon]
}

final class GetPokemonUseCase: GetPokemonUseCaseInterface {
  
  private let repository: PokemonRepositoryInterface
  
  init(repository: PokemonRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() async -> [Pokemon] {
    await repository.getPokemonList()
  }
}
