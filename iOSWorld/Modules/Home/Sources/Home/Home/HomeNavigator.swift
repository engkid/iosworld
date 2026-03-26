//
//  HomeNavigator.swift
//  Home
//
//  Created by Engkit Riswara on 26/03/26.
//

import Foundation
import UIKit
import SwiftUI

enum HomeDestinationEnum {
  case homeDetail(HomeViewModel)
  case profile
}

public final class HomeNavigator {
  
  public init() {}
  
  @MainActor func navigate(from viewController: UIViewController, to destination: HomeDestinationEnum) {
    switch destination {
    case .homeDetail(let viewModel):
      
      let detailController = UIHostingController(rootView: HomeDetailView(viewModel: viewModel))
      detailController.hidesBottomBarWhenPushed = true
      detailController.title = "Home Detail"
      viewController.navigationController?.pushViewController(detailController, animated: true)
      
      return
    case .profile:
      return
    }
  }
  
}
