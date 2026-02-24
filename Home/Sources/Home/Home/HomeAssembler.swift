//
//  HomeAssembler.swift
//  Home
//
//  Created by Engkit Riswara on 24/02/26.
//

import Factory

extension Container {
  
  var homeViewModel: Factory<HomeViewModel> {
    Factory(self) {
      HomeViewModel(
        title: "Home",
        subtitle: "Welcome back! Explore updates and highlights."
      )
    }
  }
  
}
