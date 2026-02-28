import Foundation

final class ModuleLaunchable: Launchable {
  let route: ModuleRoute
  weak var launcher: Launching?

  init(route: ModuleRoute) {
    self.route = route
  }

  func launch() {
    launcher?.launch(route: route)
  }
}
