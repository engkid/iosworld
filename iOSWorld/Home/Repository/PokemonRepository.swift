import Foundation
import NetworkService

// Repository demonstrating how to use NetworkLayer to fetch data
protocol PokemonRepositoryInterface {
  func getPokemonList() async -> [Pokemon]
}

struct PokemonRepository: PokemonRepositoryInterface {
  private let remoteDataSource: HomeRemoteDataSourceInterface

  init(remoteDataSource: HomeRemoteDataSourceInterface = HomeRemoteDataSource(networkLayer: NetworkLayer())) {
    self.remoteDataSource = remoteDataSource
  }

  func getPokemonList() async -> [Pokemon] {
    return await remoteDataSource.getPokemonList(name: "")
  }
}

// Example usage helper for quick manual testing (not executed automatically)
enum PokemonExampleRunner {
  static func runExample() async -> [Pokemon] {
    let repo = PokemonRepository()
    return await repo.getPokemonList()
  }
}

