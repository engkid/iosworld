//
//  HomeModuleBuilding.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 25/02/26.
//

import Home

protocol HomeModuleBuilding: AnyObject {
  func makeHomeView() -> HomeView
}
