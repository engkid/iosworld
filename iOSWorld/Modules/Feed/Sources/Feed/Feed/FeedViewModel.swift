import Foundation
import Combine

public final class FeedViewModel: ObservableObject {
  public let title: String
  public let subtitle: String
  private var intentHandler: (FeedIntent) -> Void

  public init(
    title: String,
    subtitle: String,
    intentHandler: @escaping (FeedIntent) -> Void = { _ in }
  ) {
    self.title = title
    self.subtitle = subtitle
    self.intentHandler = intentHandler
  }

  public func setIntentHandler(_ handler: @escaping (FeedIntent) -> Void) {
    intentHandler = handler
  }

  public func openArticles() {
    intentHandler(.openArticles)
  }
}
