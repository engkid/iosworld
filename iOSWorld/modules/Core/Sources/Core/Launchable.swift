//
//  Launchable.swift
//  Core
//
//  Created by Engkit Riswara on 03/03/26.
//

import Foundation

public protocol Launchable {
  var launcher: Launching? { get set }
  func launch(moduleName: String)
}

public protocol Launching: AnyObject {
  func launch(route: ModuleRoute)
}
