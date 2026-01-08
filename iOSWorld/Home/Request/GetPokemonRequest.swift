//
//  GetPokemonRequest.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 08/01/26.
//

import Foundation
import NetworkService

// Request type conforming to APIRequest for fetching a Pokemon by name
public struct GetPokemonRequest: APIRequest {
  public let name: String
  public init(name: String) { self.name = name }

  public var baseURL: URL { URL(string: DomainConfiguration.baseURL)! }
  public var path: String { "/pokemon" }
  public var method: HTTPMethod { .get }
  public var queryItems: [URLQueryItem]? { [URLQueryItem(name: "limit", value: "20"), URLQueryItem(name: "offset", value: "0")] }
  public var body: Body { .none }
}
