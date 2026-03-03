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
  @Injected(\.tabRouter) var tabRouter

  var body: some View {
    ZStack(alignment: .bottom) {
      ZStack { tabContent }
      .animation(.spring(response: 0.4, dampingFraction: 0.85), value: viewModel.selectedTab)
      
      iOSWorldTabView(viewModel: viewModel)
        .padding(.bottom, 8)
    }
    .onChange(of: viewModel.selectedTab) { _, selectedTab in
      onTabSelected(selectedTab)
    }
    .onAppear {
      
      viewModel.configureItems(
        homeModuleBuilder: homeModuleBuilder,
        feedModuleBuilder: feedModuleBuilder,
        tabRouter: tabRouter
      )
      
    }
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

    tabRouter.launch(route: route)
  }
}

#Preview {
  MainTabView()
}
