//
//  TabRouter.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 26/02/26.
//

import Foundation
import SwiftUI
import Home
import Feed
import Core
import UIKit

protocol TabRouting: AnyObject {
  
  func launch(route: ModuleRoute)
  
  @MainActor
  func makeMainTabControllers() -> [UIViewController]
  
  @MainActor
  func makeHomeRoot() -> AnyView
  @MainActor
  func makeFeedRoot() -> AnyView
}

final class TabRouter: TabRouting {
  private let moduleManager: ModuleManaging
  private let homeModuleBuilder: HomeModuleBuilding
  private let feedModuleBuilder: FeedModuleBuilding
  
  init(
    moduleManager: ModuleManaging,
    homeModuleBuilder: HomeModuleBuilding,
    feedModuleBuilder: FeedModuleBuilding
  ) {
    self.moduleManager = moduleManager
    self.homeModuleBuilder = homeModuleBuilder
    self.feedModuleBuilder = feedModuleBuilder
  }
  
  func launch(route: ModuleRoute) {
    moduleManager.launch(to: route)
  }

  @MainActor
  func makeMainTabControllers() -> [UIViewController] {
    let homeRootView = homeModuleBuilder.makeHomeView()
    let homeRootController = homeRootView.viewController
    homeRootController.title = TabItem.home.title
    let homeNavigationController = UINavigationController(rootViewController: homeRootController)
    homeNavigationController.tabBarItem = UITabBarItem(
      title: TabItem.home.title,
      image: UIImage(systemName: TabItem.home.iconName),
      selectedImage: UIImage(systemName: TabItem.home.iconName)
    )

    let feedRootController = UIHostingController(
      rootView: NavigationStack {
        feedModuleBuilder.makeFeedView()
      }
    )
    feedRootController.title = TabItem.feed.title
    let feedNavigationController = UINavigationController(rootViewController: feedRootController)
    feedNavigationController.tabBarItem = UITabBarItem(
      title: TabItem.feed.title,
      image: UIImage(systemName: TabItem.feed.iconName),
      selectedImage: UIImage(systemName: TabItem.feed.iconName)
    )

    return [homeNavigationController, feedNavigationController]
  }

  @MainActor
  func makeHomeRoot() -> AnyView {
    AnyView(WrappedNavigationController(rootView: homeModuleBuilder.makeHomeView()))
  }
  
  @MainActor
  func makeFeedRoot() -> AnyView {
    AnyView(
      NavigationStack {
        feedModuleBuilder.makeFeedView()
      }
    )
  }
  
}
