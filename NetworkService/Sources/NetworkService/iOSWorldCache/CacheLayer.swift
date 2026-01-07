//
//  CacheLayer.swift
//  NetworkService
//
//  Created by Engkit Riswara on 07/01/26.
//

import Foundation

public protocol CacheLayerInterface {
  func cache<T: Codable>(for key: String, value: T)
}

public final class CacheLayer: CacheLayerInterface {
  
  public init() {}
  
  public func cache<T: Codable>(for key: String, value: T) {
    
  }
}
