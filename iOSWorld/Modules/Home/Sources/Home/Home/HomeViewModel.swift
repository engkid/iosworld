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
  
  public init(
    title: String,
    subtitle: String
  ) {
    self.title = title
    self.subtitle = subtitle
  }
}
