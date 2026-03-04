//
//  TabRouter.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 26/02/26.
//

import Foundation
import SwiftUI
import Home
import Core

protocol TabRouting: AnyObject {
  var launcher: Launching? { get set }
  
  func launch(route: ModuleRoute)
  
  @MainActor
  func makeHomeRoot(homeModuleBuilder: HomeModuleBuilding) -> AnyView
}

final class TabRouter: TabRouting {
  private let moduleManager: ModuleManaging
  
  var launcher: Launching?
  
  init(moduleManager: ModuleManaging) {
    self.moduleManager = moduleManager
  }
  
  func launch(route: ModuleRoute) {
    moduleManager.launch(to: route)
  }

  @MainActor
  func makeHomeRoot() -> AnyView {
    AnyView(
      NavigationStack {
        homeModuleBuilder.makeHomeView()
      }
    )
  }
  
  @MainActor
  func makeFeedRoot() -> AnyView {
    AnyView(
      NavigationStack {
        feedModuleBuilder.makeFeedView()
      }
    )
  }
  
  @MainActor
  func makeArticlesView() -> AnyView {
    AnyView(ArticlesTabView())
  }
  
  @MainActor
  func makeProfileView() -> AnyView {
    AnyView(ProfileTabView())
  }
  
}
