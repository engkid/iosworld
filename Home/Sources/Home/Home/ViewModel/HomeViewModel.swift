//
//  HomeViewModel.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import Factory
import Combine
import NetworkService

final class HomeViewModel: ObservableObject {
  
  @Injected(\.getPokemonListUseCase) private var getPokemonUseCase: GetPokemonUseCaseInterface
  
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
