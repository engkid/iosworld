//
//  ModuleManager.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 26/02/26.
//

import Foundation
import Home

protocol Launching: AnyObject {
  func launch(route: ModuleRoute)
}

protocol ModuleManaging: AnyObject {
  func setLauncher(_ launcher: Launching)
  func handle(homeIntent: HomeIntent)
}

enum ModuleRoute {
  case home
  case feed
  case profile
  case articles
}

final class ModuleManager: ModuleManaging {
  
  private weak var launcher: Launching?
  
  func setLauncher(_ launcher: Launching) {
    self.launcher = launcher
  }
  
  func handle(homeIntent: HomeIntent) {
    switch homeIntent {
    case .openProfile:
      launcher?.launch(route: .profile)
    }
  }
  
}
