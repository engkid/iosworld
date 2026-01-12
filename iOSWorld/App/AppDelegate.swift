import SwiftUI
import UIKit
import os

final class AppDelegate: NSObject, UIApplicationDelegate {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "iOSWorld", category: "AppDelegate")
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Perform SDK initialization here
        // Example:
        // MySDK.initialize(withAPIKey: "YOUR_KEY")
        Self.logger.info("didFinishLaunchingWithOptions called. Launch options: \(String(describing: launchOptions))")
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Self.logger.info("applicationDidBecomeActive")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Self.logger.info("applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Self.logger.info("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Self.logger.info("applicationWillEnterForeground")
    }
}
