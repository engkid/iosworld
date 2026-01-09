import Foundation
import NetworkService

enum PokemonAPI: APIRequest {
  
  case getPokemonList
  
  var baseURL: URL {
    switch self {
    case .getPokemonList:
      return URL(string: "https://pokeapi.co/api/v2")!
    }
  }
  
  var path: String {
    switch self {
    case .getPokemonList:
      return "/pokemon"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getPokemonList:
      return .get
    }
  }
  
  var queryItem: [URLQueryItem]? {
    switch self {
    case .getPokemonList:
      var items: [URLQueryItem] = []
      items.append(URLQueryItem(name: "limit", value: String(20)))
      items.append(URLQueryItem(name: "offset", value: String(0)))
      return items.isEmpty ? nil : items
    }
  }
  
  var body: Body {
    switch self {
    case .getPokemonList:
      return .none
    }
  }
  
}
