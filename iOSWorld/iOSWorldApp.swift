//
//  iOSWorldApp.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI

@main
struct iOSWorldApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(navigator: HomeNavigator())
        }
    }
}
