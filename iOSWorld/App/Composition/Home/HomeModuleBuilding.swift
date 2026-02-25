//
//  HomeModuleBuilding.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 25/02/26.
//

import Home
import SwiftUI

protocol HomeModuleBuilding: AnyObject {
  func makeHomeView(
    onIntent: @escaping (HomeIntent) -> Void,
    profileDestination: @escaping () -> AnyView
  ) -> HomeView
}
