//
//  Pokemon.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 08/01/26.
//

import Foundation

// Simple model to decode a subset of the PokeAPI response
struct Pokemon: Decodable, Sendable {
  let name: String
  let url: String
}
