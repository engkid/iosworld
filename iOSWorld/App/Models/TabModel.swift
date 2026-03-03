//
//  TabModel.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 25/02/26.
//

import Foundation
import SwiftUI

struct TabModel: Identifiable, Equatable {
  let tab: TabItem
  var isSelected: Bool
  let view: AnyView
  
  var id: TabItem { tab }
  var title: String { tab.title }
  var iconName: String { tab.iconName }

  static func == (lhs: TabModel, rhs: TabModel) -> Bool {
    lhs.tab == rhs.tab && lhs.isSelected == rhs.isSelected
  }
}
