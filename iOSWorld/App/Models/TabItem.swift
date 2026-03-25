//
//  TabItem.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 25/02/26.
//

import Foundation

enum TabItem: Int, CaseIterable {
  case home = 0
  case feed
  case articles
  case profile
  
  var title: String {
    switch self {
    case .home:
      return "Home"
    case .feed:
      return "Feed"
    case .profile:
      return "Profile"
    case .articles:
      return "Articles"
    }
  }

  var iconName: String {
    switch self {
    case .home:
      return "house.fill"
    case .feed:
      return "text.page"
    case .profile:
      return "person.crop.circle.fill"
    case .articles:
      return "doc.text.image"
    }
  }
}
