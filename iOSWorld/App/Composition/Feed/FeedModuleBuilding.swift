import Feed

protocol FeedModuleBuilding: AnyObject {
  func makeFeedView(onIntent: @escaping (FeedIntent) -> Void) -> FeedView
}
