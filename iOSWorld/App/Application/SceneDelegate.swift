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

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "iOSWorld", category: "SceneDelegate")
  
  var window: UIWindow?
  private let moduleManager: ModuleManaging = Container.shared.moduleManager()
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    registerModules()
    
    let window = UIWindow(windowScene: windowScene)
    
    // TODO: make DI at app start (do it for later)
    let tabRouter = Container.shared.tabRouter()
    let moduleManager = Container.shared.moduleManager()
    let homeCompositionRoot = Container.shared.homeCompositionRoot()
    
    window.rootViewController = UIHostingController(rootView: MainTabView())
    
    window.makeKeyAndVisible()
    self.window = window
    
    Self.logger.info("willConnectTo: SceneDelegate is being called. Launch options: \(String(describing: connectionOptions))")
  }
  
  private func registerModules() {
    moduleManager.registerModules([
      HomeModule(launcher: self)
    ])
  }
  
}

extension SceneDelegate: Launching {
  
  func launch(route: ModuleRoute) {
    Self.logger.info("launch: Launching module for route: \(String(describing: route))")
  }
  
}
