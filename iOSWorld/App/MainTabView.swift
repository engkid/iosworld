//
//  ContentView.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI
import Factory
import Foundation
import Home
import Core

@MainActor
struct MainTabView: View {
  
  @InjectedObject(\.tabBarViewModel) var viewModel
  @Injected(\.homeCompositionRoot) var homeModuleBuilder
  @Injected(\.feedCompositionRoot) var feedModuleBuilder
  @Injected(\.moduleManager) var moduleManager
  @Injected(\.tabRouter) var tabRouter
  @State private var hiddenTabs: Set<String> = []

  var body: some View {
    ZStack(alignment: .bottom) {
      ZStack { tabContent }
      .animation(.spring(response: 0.4, dampingFraction: 0.85), value: viewModel.selectedTab)

      if !isTabBarHidden {
        iOSWorldTabView(viewModel: viewModel)
          .padding(.bottom, 8)
      }
    }
    .onReceive(NotificationCenter.default.publisher(for: TabBarVisibilityNotification.name)) { notification in
      guard
        let tab = notification.userInfo?[TabBarVisibilityNotification.tabKey] as? String,
        let isHidden = notification.userInfo?[TabBarVisibilityNotification.isHiddenKey] as? Bool
      else {
        return
      }

      if isHidden {
        hiddenTabs.insert(tab)
      } else {
        hiddenTabs.remove(tab)
      }
    }
    .onChange(of: viewModel.selectedTab) { _, selectedTab in
      onTabSelected(selectedTab)
    }
    .onAppear {
      
      viewModel.configureItems(
        homeModuleBuilder: homeModuleBuilder,
        feedModuleBuilder: feedModuleBuilder,
        moduleManager: moduleManager,
        tabRouter: tabRouter
      )
      
    }
  }

  private var isTabBarHidden: Bool {
    hiddenTabs.contains(selectedTabIdentifier)
  }

  private var selectedTabIdentifier: String {
    switch viewModel.selectedTab {
    case .home:
      return "home"
    case .feed:
      return "feed"
    case .articles:
      return "articles"
    case .profile:
      return "profile"
    }
  }

  @ViewBuilder
  private var tabContent: some View {
    ForEach(viewModel.items) { item in
      item.view
        .opacity(item.tab == viewModel.selectedTab ? 1 : 0)
        .allowsHitTesting(item.tab == viewModel.selectedTab)
    }
  }

  private func onTabSelected(_ tab: TabItem) {
    let route: ModuleRoute

    switch tab {
    case .home:
      route = .home
    case .feed:
      route = .feed
    case .articles:
      route = .articles
    case .profile:
      route = .profile
    }

    moduleManager.launch(to: route)
  }
}

#Preview {
  MainTabView()
}

private enum TabBarVisibilityNotification {
  static let name = Notification.Name("iOSWorld.TabBarVisibilityChanged")
  static let tabKey = "tab"
  static let isHiddenKey = "isHidden"
}
