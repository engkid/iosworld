import Testing
import Core
@testable import iOSWorld

struct ModuleManagerTests {

  @Test
  func registerModules_storesGivenModules() {
    let sut = ModuleManager()
    let home = HomeModule()
    let feed = FeedModule()

    sut.registerModules([home, feed])

    #expect(sut.moduleLaunchables.count == 2)
    #expect((sut.moduleLaunchables[0] as AnyObject) === home)
    #expect((sut.moduleLaunchables[1] as AnyObject) === feed)
  }

  @Test
  func launch_matchingRoute_launchesOnlyMatchingModule() {
    let sut = ModuleManager()
    let home = HomeModule()
    let feed = FeedModule()

    sut.registerModules([home, feed])
    sut.launch(to: .feed)

    #expect(home.launchedModuleNames.isEmpty)
    #expect(feed.launchedModuleNames == ["feed"])
  }

  @Test
  func launch_unmatchedRoute_doesNothing() {
    let sut = ModuleManager()
    let home = HomeModule()
    let feed = FeedModule()

    sut.registerModules([home, feed])
    sut.launch(to: .articles)

    #expect(home.launchedModuleNames.isEmpty)
    #expect(feed.launchedModuleNames.isEmpty)
  }

  @Test
  func launch_passesExactRouteDescriptionToLaunchable() {
    let sut = ModuleManager()
    let articles = ArticlesModule()

    sut.registerModules([articles])
    sut.launch(to: .articles)

    #expect(articles.launchedModuleNames == ["articles"])
  }
}

private final class HomeModule: Launchable {
  var launcher: Launching?
  private(set) var launchedModuleNames: [String] = []

  func launch(moduleName: String) {
    launchedModuleNames.append(moduleName)
  }
}

private final class FeedModule: Launchable {
  var launcher: Launching?
  private(set) var launchedModuleNames: [String] = []

  func launch(moduleName: String) {
    launchedModuleNames.append(moduleName)
  }
}

private final class ArticlesModule: Launchable {
  var launcher: Launching?
  private(set) var launchedModuleNames: [String] = []

  func launch(moduleName: String) {
    launchedModuleNames.append(moduleName)
  }
}
