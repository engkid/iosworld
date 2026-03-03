//
//  HomeModule.swift
//  Home
//
//  Created by Engkit Riswara on 03/03/26.
//

import Foundation
import Core

public final class HomeModule: Launchable {
  
  public var launcher: Launching?
  
  public init(launcher: Launching?) {
    self.launcher = launcher
  }
  
  public func launch(moduleName: String) {
    launcher?.launch(route: .home)
  }
  
}
