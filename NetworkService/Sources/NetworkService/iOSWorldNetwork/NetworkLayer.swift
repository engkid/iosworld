//
//  NetworkLayer.swift
//  NetworkService
//
//  Created by Engkit Riswara on 07/01/26.
//

import Foundation

public enum NetworkError: Error {
  case invalidResponse
  case unacceptableStatusCode(Int)
}

public protocol NetworkSession {
  func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {
  public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    try await self.data(for: request, delegate: nil)
  }
}

public protocol NetworkLayerInterface {
  func makeURLRequest<R: APIRequest>(from request: R) throws -> URLRequest
  func send<R: APIRequest>(_ request: R) async throws -> Data
  func send<R: APIRequest, T: Decodable>(_ request: R, decode type: T.Type) async throws -> T
}

public final class NetworkLayer: NetworkLayerInterface {
  
  private let session: NetworkSession
  
  public init(session: NetworkSession = URLSession.shared) {
    self.session = session
  }
  
  public func makeURLRequest<R: APIRequest>(from request: R) throws -> URLRequest {
    try APIRequestBuilder.makeURLRequest(from: request)
  }
  
  public func send<R: APIRequest>(_ request: R) async throws -> Data {
    let urlRequest = try makeURLRequest(from: request)
    let (data, response) = try await session.data(for: urlRequest)
    guard let http = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
    guard (200..<300).contains(http.statusCode) else { throw NetworkError.unacceptableStatusCode(http.statusCode) }
    return data
  }
  
  public func send<R: APIRequest, T: Decodable>(_ request: R, decode type: T.Type) async throws -> T {
    let data = try await send(request)
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  }
}

// Example request types for demonstration/testing. Consider moving these to a sample or test target.

struct GetPokemonName: APIRequest {
  let name: String
  let baseURL: URL = URL(string: DomainConfiguration.baseURL)!
  let path: String = PokemonAPI(route: .pokemon).path
  let method: HTTPMethod = .get
  let queryItems: [URLQueryItem]? = nil
  var body: Body { .json(PokemonPayload(name: name)) }
}

struct PokemonPayload: Encodable {
  let name: String
}

enum EndpointPath {
  case pokemon
  case ability
  case nature
}

struct PokemonAPI {
  let route: EndpointPath
  
  var path: String {
    switch route {
    case .pokemon:
      return "/pokemon"
    case .ability:
      return "/ability"
    case .nature:
      return "/nature"
    }
  }
}
