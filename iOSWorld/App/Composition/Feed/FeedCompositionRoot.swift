import Factory
import Feed

extension Container {

  var feedViewModel: Factory<FeedViewModel> {
    Factory(self) {
      FeedViewModel(
        title: "Feed",
        subtitle: "Your personalized feed appears here."
      )
    }
  }

  var feedCompositionRoot: Factory<FeedModuleBuilding> {
    Factory(self) {
      FeedCompositionRoot(container: self)
    }
    .singleton
  }
}

final class FeedCompositionRoot: FeedModuleBuilding {
  private let container: Container
  private lazy var feedViewModel: FeedViewModel = container.feedViewModel()

  init(container: Container = .shared) {
    self.container = container
  }

  func makeFeedView(onIntent: @escaping (FeedIntent) -> Void) -> FeedView {
    feedViewModel.setIntentHandler(onIntent)
    return FeedView(viewModel: feedViewModel)
  }
}
