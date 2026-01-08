//
//  HomeViewModel.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import Combine
import NetworkService

final class HomeViewModel: ObservableObject {
  
  private let getPokemonUseCase: GetPokemonUseCaseInterface
  
  init(
    getPokemonUseCase: GetPokemonUseCaseInterface = GetPokemonUseCase(
      repository: PokemonRepository(
        remoteDataSource: HomeRemoteDataSource(
          networkLayer: NetworkLayer()
        )
      )
    )
  ) {
    self.getPokemonUseCase = getPokemonUseCase
  }
  
  func getPokemonList() {
    
    Task {
      let pokemonList = await getPokemonUseCase.execute()
      print("fetched pokemons \(pokemonList)")
      
    }
  }
  
  func callNetwork() {
    Task {
      let pokemons = await PokemonExampleRunner.runExample()
      print("fetched pokemons \(pokemons)")
      
    }
  }
  
}
