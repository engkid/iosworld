//
//  ModuleRoute.swift
//  Core
//
//  Created by Engkit Riswara on 03/03/26.
//

import Foundation

public enum ModuleRoute: Hashable, CustomStringConvertible {
  case home
  case feed
  case profile
  case articles

  public var description: String {
    switch self {
    case .home:
      return "home"
    case .feed:
      return "feed"
    case .profile:
      return "profile"
    case .articles:
      return "articles"
    }
  }
}
