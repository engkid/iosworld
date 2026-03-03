//
//  ModuleManager.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 26/02/26.
//

import Foundation
import Home
import Core

protocol ModuleManaging: AnyObject {
  func launch(to route: ModuleRoute)
  func registerModules(_ modules: [Launchable])
}

final class ModuleManager: ModuleManaging {
  
  private var modulesLaunchable: [Launchable] = []

  init() { }
  
  func registerModules(_ modules: [Launchable]) {
    self.modulesLaunchable = modules
  }
  
  func launch(to route: ModuleRoute) {
    modulesLaunchable.first?.launch(moduleName: route.description)
  }

}
