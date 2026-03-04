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

protocol TabRouting: AnyObject {
  
  func launch(route: ModuleRoute)
  
  @MainActor
  func makeHomeRoot() -> AnyView
  @MainActor
  func makeFeedRoot() -> AnyView
  @MainActor
  func makeArticlesView() -> AnyView
  @MainActor
  func makeProfileView() -> AnyView
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
  
  @MainActor
  func makeArticlesView() -> AnyView {
    AnyView(ArticlesTabView())
  }
  
  @MainActor
  func makeProfileView() -> AnyView {
    AnyView(ProfileTabView())
  }
  
}
