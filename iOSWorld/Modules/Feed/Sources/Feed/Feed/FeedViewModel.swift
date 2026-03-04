import Foundation
import Combine

public final class FeedViewModel: ObservableObject {
  public let title: String
  public let subtitle: String

  public init(
    title: String,
    subtitle: String
  ) {
    self.title = title
    self.subtitle = subtitle
  }
}
