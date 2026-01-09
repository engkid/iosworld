//
//  HomeAssembly.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 09/01/26.
//

import Factory
import NetworkService

extension Container {
  // Lowest level
  var networkLayer: Factory<NetworkLayer> {
    Factory(self) { NetworkLayer() }
  }

  // Data source
  var pokemonRemoteDataSource: Factory<PokemonRemoteDataSourceInterface> {
    Factory(self) { PokemonRemoteDataSource(networkLayer: self.networkLayer()) }
  }

  // Repository
  var pokemonRepository: Factory<PokemonRepositoryInterface> {
    Factory(self) { PokemonRepository(remoteDataSource: self.pokemonRemoteDataSource()) }
  }

  // Use case
  var getPokemonListUseCase: Factory<GetPokemonUseCaseInterface> {
    Factory(self) { GetPokemonUseCase(repository: self.pokemonRepository()) }
  }
}

