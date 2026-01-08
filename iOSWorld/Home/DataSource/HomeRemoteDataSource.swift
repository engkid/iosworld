//
//  HomeRemoteDataSource.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import Foundation
import NetworkService

protocol HomeRemoteDataSourceInterface {
  func getPokemonList(name: String) async -> [Pokemon]
}

final class HomeRemoteDataSource: HomeRemoteDataSourceInterface {
  
  private let networkLayer: NetworkLayerInterface
  
  init(networkLayer: NetworkLayer) {
    self.networkLayer = networkLayer
  }
  
  func getPokemonList(name: String) async -> [Pokemon] {
    let request = GetPokemonRequest(name: name)
    do {
      let response = try await networkLayer.send(request, decode: PokemonListResponse.self)
      let pokemons = response.results.map { Pokemon(name: $0.name, url: $0.url) }
      return pokemons
    } catch {
      print("Failed to fetch Pokemon list \(error)")
      return []
    }
  }
}

