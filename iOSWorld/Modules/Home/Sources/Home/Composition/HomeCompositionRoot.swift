import Foundation
import Core

public final class HomeCompositionRoot: HomeModuleBuilding {
  private let viewModelBuilder: () -> HomeViewModel

  public init(viewModelBuilder: @escaping () -> HomeViewModel = {
    HomeViewModel(
      title: "Home",
      subtitle: "Welcome back! Explore updates and highlights."
    )
  }) {
    self.viewModelBuilder = viewModelBuilder
  }

  public func makeHomeView() -> HomeView {
    HomeView(holder: WrapperHolder(), viewModel: viewModelBuilder(), navigator: HomeNavigator())
  }
}
