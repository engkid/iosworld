//
//  TabRouter.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 26/02/26.
//

import Foundation

protocol TabRouting: AnyObject, Launching {
  func bindTabSelection(_ handler: @escaping (TabItem) -> Void)
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
  
}
