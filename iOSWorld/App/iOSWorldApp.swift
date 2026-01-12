//
//  iOSWorldApp.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI
import Home
import UIKit

@main
struct iOSWorldApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView(navigator: HomeNavigator())
                    .tabItem {
                        Label("Main", systemImage: "square.grid.2x2")
                    }

                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
            }
        }
    }
}
