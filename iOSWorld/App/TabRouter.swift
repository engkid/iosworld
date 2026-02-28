//
//  TabRouter.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 26/02/26.
//

import Foundation
import SwiftUI
import Home

protocol TabRouting: AnyObject, Launching {
  func bindTabSelection(_ handler: @escaping (TabItem) -> Void)
  @MainActor
  func makeHomeRoot(homeModuleBuilder: HomeModuleBuilding, moduleManager: ModuleManaging) -> AnyView
}

final class TabRouter: TabRouting {
  private var tabSelectionHandler: ((TabItem) -> Void)?

  func bindTabSelection(_ handler: @escaping (TabItem) -> Void) {
    tabSelectionHandler = handler
  }
  
  func launch(route: ModuleRoute) {
    let tab: TabItem

    switch route {
    case .home:
      tab = .home
    case .feed:
      tab = .feed
    case .profile:
      tab = .profile
    case .articles:
      tab = .articles
    }

    Task { @MainActor in
      self.tabSelectionHandler?(tab)
    }
  }

  @MainActor
  func makeHomeRoot(homeModuleBuilder: HomeModuleBuilding, moduleManager: ModuleManaging) -> AnyView {
    AnyView(
      NavigationStack {
        homeModuleBuilder.makeHomeView { intent in
          moduleManager.handle(homeIntent: intent)
        } profileDestination: {
          AnyView(EmptyView())
        }
      }
    )
  }
  
}
