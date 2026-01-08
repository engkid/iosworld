import Foundation

// Simple model to decode a subset of the PokeAPI response
public struct Pokemon: Decodable, Sendable {
  public let userId: Int
  public let id: Int
  public let title: String
  public let completed: Bool
}

// Request type conforming to APIRequest for fetching a Pokemon by name
public struct GetPokemonRequest: APIRequest {
  public let name: String
  public init(name: String) { self.name = name }

  public var baseURL: URL { URL(string: DomainConfiguration.baseURL)! }
  public var path: String { "/todos" }
  public var method: HTTPMethod { .get }
  public var queryItems: [URLQueryItem]? { nil }
  public var body: Body { .none }
}

// Repository demonstrating how to use NetworkLayer to fetch data
public protocol PokemonRepositoryInterface {
  func fetchPokemon(named name: String) async throws -> [Pokemon]
}

public struct PokemonRepository: PokemonRepositoryInterface {
  private let network: NetworkLayerInterface

  public init(network: NetworkLayerInterface = NetworkLayer()) {
    self.network = network
  }

  public func fetchPokemon(named name: String) async throws -> [Pokemon] {
    let request = GetPokemonRequest(name: name)
    return try await network.send(request, decode: [Pokemon].self)
  }
}

// Example usage helper for quick manual testing (not executed automatically)
public enum PokemonExampleRunner {
  public static func runExample() async -> [Pokemon] {
    let repo = PokemonRepository()
    do {
      let todos = try await repo.fetchPokemon(named: "pikachu")
      if let first = todos.first {
        print("Fetched Pokemon: \(first.title) id: \(first.id)")
      }
      return todos
    } catch {
      print("Failed to fetch Pokemon: \(error)")
      return []
    }
  }
}

