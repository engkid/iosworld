import Feed

protocol FeedModuleBuilding: AnyObject {
  func makeFeedView() -> FeedView
}
