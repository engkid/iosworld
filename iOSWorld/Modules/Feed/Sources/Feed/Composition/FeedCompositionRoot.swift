import Foundation

public final class FeedCompositionRoot: FeedModuleBuilding {
  private let viewModelBuilder: () -> FeedViewModel

  public init(viewModelBuilder: @escaping () -> FeedViewModel = {
    FeedViewModel(
      title: "Feed",
      subtitle: "Your personalized feed appears here."
    )
  }) {
    self.viewModelBuilder = viewModelBuilder
  }

  public func makeFeedView() -> FeedView {
    FeedView(viewModel: viewModelBuilder())
  }
}
