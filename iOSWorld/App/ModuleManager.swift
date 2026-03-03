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
    let routeName = route.description.lowercased()
    let launchable = modulesLaunchable.first { moduleIdentifier(for: $0) == routeName }
    launchable?.launch(moduleName: route.description)
  }
  
  private func moduleIdentifier(for launchable: Launchable) -> String {
    var typeName = String(describing: type(of: launchable)).lowercased()

    if let scopedTypeName = typeName.split(separator: ".").last {
      typeName = String(scopedTypeName)
    }

    if typeName.hasSuffix("module") {
      typeName.removeLast("module".count)
    }

    return typeName
  }

}
