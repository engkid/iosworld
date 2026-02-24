//
//  TabBarViewModel.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 25/02/26.
//

import Foundation
import Combine

@MainActor
final class TabBarViewModel: ObservableObject {
  
  @Published private(set) var items: [TabModel]
  @Published private(set) var selectedTab: TabItem
  
  init(defaultTab: TabItem = .home) {
    self.selectedTab = defaultTab
    self.items = TabItem.allCases.map { TabModel(tab: $0, isSelected: $0 == defaultTab) }
  }
  
  func select(_ tab: TabItem) {
    guard tab != selectedTab else { return }
    
    selectedTab = tab
    for i in items.indices {
      items[i].isSelected = (items[i].tab == tab)
    }
  }
}
