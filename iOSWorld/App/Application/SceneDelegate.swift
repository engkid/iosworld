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
import Home
import Core
import Feed

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "iOSWorld", category: "SceneDelegate")
  
  var window: UIWindow?
  private let moduleManager: ModuleManaging = Container.shared.moduleManager()
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    registerModules()
    
    let window = UIWindow(windowScene: windowScene)
    
    let mainTabView: AnyView = moduleManager.initialView
    
    window.rootViewController = UIHostingController(rootView: mainTabView)
    
    window.makeKeyAndVisible()
    self.window = window
    
    Self.logger.info("willConnectTo: SceneDelegate is being called. Launch options: \(String(describing: connectionOptions))")
  }
  
  private func registerModules() {
    moduleManager.registerModules([
      HomeModule(launcher: self),
      FeedModule(launcher: self)
    ])
  }
  
}

extension SceneDelegate: Launching {
  
  func launch(route: ModuleRoute) {
    Self.logger.info("launch: Launching module for route: \(String(describing: route))")
  }
  
}
