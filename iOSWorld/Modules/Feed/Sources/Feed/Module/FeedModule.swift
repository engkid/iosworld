import Foundation
import Core

public final class FeedModule: Launchable {

  public var launcher: Launching?

  public init(launcher: Launching?) {
    self.launcher = launcher
  }

  public func launch(moduleName: String) {
    launcher?.launch(route: .feed)
  }
}
