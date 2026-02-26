//
//  iOSWorldApp.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI
import Home
import UIKit
import Combine
import Factory

@main
struct iOSWorldApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      MainTabView()
    }
  }
}
