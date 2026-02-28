//
//  SceneDelegate.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 28/02/26.
//

import Foundation
import SwiftUI
import os
import Factory

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "iOSWorld", category: "SceneDelegate")
  
  var window: UIWindow?
  private let moduleManager: ModuleManaging = Container.shared.moduleManager()
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    registerModules()
    
    let window = UIWindow(windowScene: windowScene)
    
    window.rootViewController = UIHostingController(rootView: MainTabView())
    
    window.makeKeyAndVisible()
    self.window = window
    
    Self.logger.info("willConnectTo: SceneDelegate is being called. Launch options: \(String(describing: connectionOptions))")
  }

  private func registerModules() {
    moduleManager.registerModules([
      ModuleLaunchable(route: .home),
      ModuleLaunchable(route: .feed),
      ModuleLaunchable(route: .articles),
      ModuleLaunchable(route: .profile)
    ])
  }
  
}
