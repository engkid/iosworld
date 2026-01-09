import Foundation
import NetworkService

// MARK: - Domain Model
public struct PokemonDomainModel: Sendable, Equatable {
  public let name: String
  public let url: String
}

// MARK: - Request
public struct GetPokemonListRequest: APIRequest {
  public init(limit: Int? = nil, offset: Int? = nil) {
    self.limit = limit
    self.offset = offset
  }
  private let limit: Int?
  private let offset: Int?

  public var baseURL: URL { URL(string: DomainConfiguration.baseURL)! }
  public var path: String { "/pokemon" }
  public var method: HTTPMethod { .get }
  public var queryItems: [URLQueryItem]? {
    var items: [URLQueryItem] = []
    if let limit { items.append(URLQueryItem(name: "limit", value: String(limit))) }
    if let offset { items.append(URLQueryItem(name: "offset", value: String(offset))) }
    return items.isEmpty ? nil : items
  }
  public var body: Body { .none }
}

// MARK: - Errors
public enum PokemonRepositoryError: Error, Sendable {
  case network(Error)
  case decoding(Error)
  case unknown
}

// MARK: - Abstractions
public protocol PokemonRepositoryInterface: Sendable {
  func getPokemonList(limit: Int?, offset: Int?) async -> Result<[PokemonDomainModel], PokemonRepositoryError>
}

protocol PokemonRemoteDataSourceInterface: Sendable {
  func fetchPokemonList(limit: Int?, offset: Int?) async throws -> PokemonListResponse
}

// MARK: - Remote Data Source
struct PokemonRemoteDataSource: PokemonRemoteDataSourceInterface {
  private let networkLayer: NetworkLayerInterface

  init(networkLayer: NetworkLayerInterface = NetworkLayer()) {
    self.networkLayer = networkLayer
  }

  func fetchPokemonList(limit: Int?, offset: Int?) async throws -> PokemonListResponse {
    let request = GetPokemonListRequest(limit: limit, offset: offset)
    return try await networkLayer.send(request, decode: PokemonListResponse.self)
  }
}

// MARK: - Repository
struct PokemonRepository: PokemonRepositoryInterface {
  private let remoteDataSource: PokemonRemoteDataSourceInterface

  init(remoteDataSource: PokemonRemoteDataSourceInterface = PokemonRemoteDataSource()) {
    self.remoteDataSource = remoteDataSource
  }

  func getPokemonList(limit: Int? = nil, offset: Int? = nil) async -> Result<[PokemonDomainModel], PokemonRepositoryError> {
    do {
      let response = try await remoteDataSource.fetchPokemonList(limit: limit, offset: offset)
      let models = response.results.map { PokemonDomainModel(name: $0.name, url: $0.url) }
      return .success(models)
    } catch let decoding as DecodingError {
      return .failure(.decoding(decoding))
    } catch {
      return .failure(.network(error))
    }
  }
}

// MARK: - Example Runner (manual testing helper)
public enum PokemonExampleRunner {
  public static func runExample() async -> [PokemonDomainModel] {
    let repo: PokemonRepositoryInterface = PokemonRepository()
    let result = await repo.getPokemonList(limit: 20, offset: 0)
    switch result {
    case .success(let list):
      return list
    case .failure(let error):
      print("Failed to fetch Pokemon list: \(error)")
      return []
    }
  }
}
