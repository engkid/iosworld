//
//  TabBarViewModeling.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 25/02/26.
//

import Combine

protocol TabBarViewModeling: ObservableObject {
  var items: [TabModel] { get }
  var selectedTab: TabItem { get }
  func select(_ tab: TabItem)
  func setItems(_ items: [TabModel])
  @MainActor
  func configureItems(
    homeModuleBuilder: HomeModuleBuilding,
    feedModuleBuilder: FeedModuleBuilding,
    tabRouter: TabRouting
  )
}
