//
//  HomeViewModel.swift
//  Home
//
//  Created by Engkit Riswara on 24/02/26.
//

import Foundation
import Combine
import SwiftUI

public final class HomeViewModel: ObservableObject {
  public let title: String
  public let subtitle: String
  private var intentHandler: (HomeIntent) -> Void
  private var profileDestinationBuilder: () -> AnyView
  
  public init(
    title: String,
    subtitle: String,
    intentHandler: @escaping (HomeIntent) -> Void = { _ in },
    profileDestinationBuilder: @escaping () -> AnyView = { AnyView(EmptyView()) }
  ) {
    self.title = title
    self.subtitle = subtitle
    self.intentHandler = intentHandler
    self.profileDestinationBuilder = profileDestinationBuilder
  }

  public func setIntentHandler(_ handler: @escaping (HomeIntent) -> Void) {
    intentHandler = handler
  }

  public func setProfileDestinationBuilder(_ builder: @escaping () -> AnyView) {
    profileDestinationBuilder = builder
  }

  public func makeProfileDestinationView() -> AnyView {
    profileDestinationBuilder()
  }

  public func openProfile() {
    intentHandler(.openProfile)
  }
}
