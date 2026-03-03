import XCTest
import Home
import Core

final class HomeModuleTests: XCTestCase {

  func test_launch_routesToHome() {
    let launcher = LaunchingSpy()
    let sut = HomeModule(launcher: launcher)

    sut.launch(moduleName: "home")

    XCTAssertEqual(launcher.launchedRoutes, [.home])
  }
}

private final class LaunchingSpy: Launching {
  private(set) var launchedRoutes: [ModuleRoute] = []

  func launch(route: ModuleRoute) {
    launchedRoutes.append(route)
  }
}
