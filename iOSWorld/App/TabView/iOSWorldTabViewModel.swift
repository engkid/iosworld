//
//  iOSWorldTabViewModel.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 25/02/26.
//

import Foundation
import Combine
import Factory
import SwiftUI

final class iOSWorldTabViewModel: TabBarViewModeling {
  
  @Published private(set) var items: [TabModel]
  @Published private(set) var selectedTab: TabItem
  
  init(defaultTab: TabItem = .home) {
    self.selectedTab = defaultTab
    self.items = TabItem.allCases.map {
      TabModel(tab: $0, isSelected: $0 == defaultTab, view: AnyView(EmptyView()))
    }
  }
  
  func select(_ tab: TabItem) {
    guard tab != selectedTab else { return }
    
    selectedTab = tab
    for i in items.indices {
      items[i].isSelected = (items[i].tab == tab)
    }
  }

  func setItems(_ items: [TabModel]) {
    guard !items.isEmpty else { return }

    if !items.contains(where: { $0.tab == selectedTab }) {
      selectedTab = items[0].tab
    }

    self.items = items.map {
      TabModel(tab: $0.tab, isSelected: $0.tab == selectedTab, view: $0.view)
    }
  }

  @MainActor
  func configureItems(
    homeModuleBuilder: HomeModuleBuilding,
    feedModuleBuilder: FeedModuleBuilding,
    moduleManager: ModuleManaging,
    tabRouter: TabRouting
  ) {
    setItems(
      makeTabItems(
        homeModuleBuilder: homeModuleBuilder,
        feedModuleBuilder: feedModuleBuilder,
        moduleManager: moduleManager,
        tabRouter: tabRouter
      )
    )
  }

  @MainActor
  private func makeTabItems(
    homeModuleBuilder: HomeModuleBuilding,
    feedModuleBuilder: FeedModuleBuilding,
    moduleManager: ModuleManaging,
    tabRouter: TabRouting
  ) -> [TabModel] {
    [
      TabModel(
        tab: .home,
        isSelected: selectedTab == .home,
        view: tabRouter.makeHomeRoot(homeModuleBuilder: homeModuleBuilder, moduleManager: moduleManager)
      ),
      TabModel(
        tab: .feed,
        isSelected: selectedTab == .feed,
        view: AnyView(
          NavigationStack {
            feedModuleBuilder.makeFeedView { _ in }
          }
        )
      ),
      TabModel(
        tab: .articles,
        isSelected: selectedTab == .articles,
        view: AnyView(ArticlesTabView())
      ),
      TabModel(
        tab: .profile,
        isSelected: selectedTab == .profile,
        view: AnyView(ProfileTabView())
      )
    ]
  }
}

extension Container {

  var tabBarViewModel: Factory<iOSWorldTabViewModel> {
    Factory(self) {
      iOSWorldTabViewModel()
    }
  }
}
