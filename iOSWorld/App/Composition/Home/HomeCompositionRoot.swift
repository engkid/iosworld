import SwiftUI
import Factory
import Home

extension Container {

  // MARK: - Init view model dependencies here
  var homeViewModel: Factory<HomeViewModel> {
    Factory(self) {
      HomeViewModel(
        title: "Home",
        subtitle: "Welcome back! Explore updates and highlights."
      )
    }
  }

  var homeCompositionRoot: Factory<HomeModuleBuilding> {
    Factory(self) {
      HomeCompositionRoot(container: self)
    }
    .singleton
  }
}

final class HomeCompositionRoot: HomeModuleBuilding {
  private let container: Container
  private lazy var homeViewModel: HomeViewModel = container.homeViewModel()

  init(container: Container = .shared) {
    self.container = container
  }

  func makeHomeView() -> HomeView {
    return HomeView(viewModel: homeViewModel)
  }
}

// MARK: Example of unit testing implementation for the future usage
#if DEBUG
final class HomeModuleBuilderFake: HomeModuleBuilding {
  private(set) var makeHomeViewCallCount = 0
  private let viewModel: HomeViewModel

  init(viewModel: HomeViewModel = HomeViewModel(title: "Home", subtitle: "Fake Home Module")) {
    self.viewModel = viewModel
  }

  func makeHomeView() -> HomeView {
    makeHomeViewCallCount += 1
    return HomeView(viewModel: viewModel)
  }
}
#endif
