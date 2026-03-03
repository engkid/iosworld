//
//  HomeDetailView.swift
//  Home
//
//  Created by Engkit Riswara on 03/03/26.
//

import Foundation
import SwiftUI

public struct HomeDetailView: View {
  let viewModel: HomeViewModel

  public init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    VStack(spacing: 16) {
      Text("Home Detail")
        .font(.title.bold())
      Text("This detail page behaves like a pushed view controller.")
        .font(.body)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
      Button("Open Profile Module") {
        viewModel.openProfile()
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.horizontal, 24)
    .background(Color(.systemGroupedBackground))
    .onAppear {
      TabBarVisibilityNotification.post(tab: "home", isHidden: true)
    }
    .onDisappear {
      TabBarVisibilityNotification.post(tab: "home", isHidden: false)
    }
  }
}

private enum TabBarVisibilityNotification {
  static let name = Notification.Name("iOSWorld.TabBarVisibilityChanged")
  static let tabKey = "tab"
  static let isHiddenKey = "isHidden"

  static func post(tab: String, isHidden: Bool) {
    NotificationCenter.default.post(
      name: name,
      object: nil,
      userInfo: [tabKey: tab, isHiddenKey: isHidden]
    )
  }
}

public protocol Launchable {
  
  var launcher: Launching? { get set }
  
  func launch(moduleName: String)
  
}

public final class HomeModule: Launchable {
  
  public var launcher: Launching?
  
  public init(launcher: Launching?) {
    self.launcher = launcher
  }
  
  public func launch(moduleName: String) {
    launcher?.launch(route: .home)
  }
  
}

public protocol Launching: AnyObject {
  func launch(route: ModuleRoute)
}

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
