//
//  NetworkLayer.swift
//  NetworkService
//
//  Created by Engkit Riswara on 07/01/26.
//

import Foundation

public protocol NetworkLayerInterface {
  func callNetwork()
}

public final class NetworkLayer: NetworkLayerInterface {
  
  public init() {}
  
  public func callNetwork() {
    
  }
}
