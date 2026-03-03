import XCTest
import Feed
import Core

final class FeedModuleTests: XCTestCase {

  func test_launch_routesToFeed() {
    let launcher = LaunchingSpy()
    let sut = FeedModule(launcher: launcher)

    sut.launch(moduleName: "feed")

    XCTAssertEqual(launcher.launchedRoutes, [.feed])
  }
}

private final class LaunchingSpy: Launching {
  private(set) var launchedRoutes: [ModuleRoute] = []

  func launch(route: ModuleRoute) {
    launchedRoutes.append(route)
  }
}
