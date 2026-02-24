//
//  TabModel.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 25/02/26.
//

import Foundation

struct TabModel: Identifiable, Equatable {
  let tab: TabItem
  var isSelected: Bool
  
  var id: TabItem { tab }
  var title: String { tab.title }
  var iconName: String { tab.iconName }
}
