//
//  HomeViewModel.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import Combine
import NetworkService

final class HomeViewModel: ObservableObject {
  
  private let networkLayer: NetworkLayer
  
  init(networkLayer: NetworkLayer) {
    self.networkLayer = networkLayer
  }
  
}
