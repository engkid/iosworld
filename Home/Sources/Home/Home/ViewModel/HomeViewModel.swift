//
//  HomeViewModel.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import Factory
import Combine
import NetworkService

public final class HomeViewModel: ObservableObject {
  
  @Injected(\.getPokemonListUseCase) private var getPokemonUseCase: GetPokemonUseCaseInterface
  @Published public private(set) var pokemons: [PokemonDomainModel] = []
  
  public init() {}
  
  public func getPokemonList() async {
    // Capture the injected dependency locally to avoid sending a non-Sendable property across an await.
    let useCase = getPokemonUseCase
    let result = await useCase.execute()
    // Assuming execute() returns [Pokemon]; adjust mapping if it returns a wrapper/result type
    self.pokemons = result
  }
  
  public func callNetwork() async {
    let fetched = await PokemonExampleRunner.runExample()
    self.pokemons = fetched
    print("fetched pokemons \(fetched)")
  }
  
}
