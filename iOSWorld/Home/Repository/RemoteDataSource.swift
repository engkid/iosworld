//
//  RemoteDataSource.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import Foundation
import NetworkService

protocol HomeRemoteDataSourceInterface {
  func getPokemonList()
}

final class HomeRemoteDataSource: HomeRemoteDataSourceInterface {
  
  private let networkLayer: NetworkLayer
  
  init(networkLayer: NetworkLayer) {
    self.networkLayer = networkLayer
  }
  
  func getPokemonList() {
    self.networkLayer.callNetwork()
  }
}
