//
//  PokemonListResponse.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 08/01/26.
//

import Foundation

struct PokemonListResponse: Decodable, Sendable, Equatable {
  
  struct Result: Decodable, Sendable, Equatable {
    let name: String
    let url: String
  }
  
  let count: Int
  let results: [Result]
}
