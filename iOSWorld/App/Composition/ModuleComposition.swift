import Factory
import Home
import Feed

extension Container {
  var homeCompositionRoot: Factory<HomeModuleBuilding> {
    Factory(self) {
      HomeCompositionRoot()
    }
    .singleton
  }

  var feedCompositionRoot: Factory<FeedModuleBuilding> {
    Factory(self) {
      FeedCompositionRoot()
    }
    .singleton
  }
}
