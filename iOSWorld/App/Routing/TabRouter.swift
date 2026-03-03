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
  
  func launch2(route: ModuleRoute)
  
  @MainActor
  func makeHomeRoot(homeModuleBuilder: HomeModuleBuilding, moduleManager: ModuleManaging) -> AnyView
}

final class TabRouter: TabRouting {
  private let moduleManager: ModuleManaging
  
  var launcher: Launching?
  
  init(moduleManager: ModuleManaging) {
    self.moduleManager = moduleManager
  }
  
  func launch2(route: ModuleRoute) {
    moduleManager.launch(to: route)
  }

  @MainActor
  func makeHomeRoot(homeModuleBuilder: HomeModuleBuilding, moduleManager: ModuleManaging) -> AnyView {
    AnyView(
      NavigationStack {
        homeModuleBuilder.makeHomeView { intent in
          
        } profileDestination: {
          AnyView(EmptyView())
        }
      }
    )
  }
  
  @MainActor
  func makeFeedView() -> AnyView {
    AnyView(FeedTabView())
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
