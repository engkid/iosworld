import Foundation

public protocol FeedModuleBuilding: AnyObject {
  func makeFeedView() -> FeedView
}
