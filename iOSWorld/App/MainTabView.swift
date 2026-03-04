//
//  MainTabView.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI
import Factory
import UIKit
import Core

@MainActor
struct MainTabView: View {
  @Injected(\.tabRouter) private var tabRouter

  var body: some View {
    MainTabBarControllerView(tabRouter: tabRouter)
      .ignoresSafeArea(.keyboard)
  }
}

private struct MainTabBarControllerView: UIViewControllerRepresentable {
  let tabRouter: TabRouting

  func makeCoordinator() -> Coordinator {
    Coordinator(tabRouter: tabRouter)
  }

  func makeUIViewController(context: Context) -> UITabBarController {
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = tabRouter.makeMainTabControllers()
    tabBarController.delegate = context.coordinator
    tabBarController.selectedIndex = 0
    tabRouter.launch(route: .home)
    return tabBarController
  }

  func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
    // Keep UIKit tab and navigation state intact across SwiftUI updates.
  }
}

private final class Coordinator: NSObject, UITabBarControllerDelegate {
  private let tabRouter: TabRouting

  init(tabRouter: TabRouting) {
    self.tabRouter = tabRouter
  }

  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    switch tabBarController.selectedIndex {
    case 0:
      tabRouter.launch(route: .home)
    case 1:
      tabRouter.launch(route: .feed)
    default:
      break
    }
  }
}

#Preview {
  MainTabView()
}
