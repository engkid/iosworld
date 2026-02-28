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

protocol Launchable: AnyObject {
  var route: ModuleRoute { get }
  var launcher: Launching? { get set }
  func launch()
}

protocol ModuleManaging: AnyObject {
  func setLauncher(_ launcher: Launching)
  func registerModules(_ modules: [Launchable])
  func navigate(to route: ModuleRoute)
  func handle(homeIntent: HomeIntent)
}

enum ModuleRoute: Hashable {
  case home
  case feed
  case profile
  case articles
}

final class ModuleManager: ModuleManaging {
  
  private weak var launcher: Launching?
  private var modulesByRoute: [ModuleRoute: Launchable] = [:]

  init() { }
  
  func setLauncher(_ launcher: Launching) {
    self.launcher = launcher
    for module in modulesByRoute.values {
      module.launcher = launcher
    }
  }

  func registerModules(_ modules: [Launchable]) {
    for module in modules {
      modulesByRoute[module.route] = module
      module.launcher = launcher
    }
  }

  func navigate(to route: ModuleRoute) {
    if let module = modulesByRoute[route] {
      module.launch()
      return
    }

    launcher?.launch(route: route)
  }
  
  func handle(homeIntent: HomeIntent) {
    switch homeIntent {
    case .openProfile:
      navigate(to: .profile)
    }
  }
  
}
