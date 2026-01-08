//
//  PokemonListResponse.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 08/01/26.
//

import Foundation

struct PokemonListResponse: Decodable, Sendable {
  
  struct Result: Decodable, Sendable {
    let name: String
    let url: String
  }
  
  let count: Int
  let results: [Result]
}
