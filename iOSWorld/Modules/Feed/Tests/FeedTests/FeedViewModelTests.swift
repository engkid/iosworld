import XCTest
import Feed

final class FeedViewModelTests: XCTestCase {

  func test_openArticles_callsIntentHandler() {
    var receivedIntent: FeedIntent?
    let sut = FeedViewModel(
      title: "Feed",
      subtitle: "Subtitle",
      intentHandler: { intent in receivedIntent = intent }
    )

    sut.openArticles()

    guard let receivedIntent else {
      XCTFail("Expected FeedIntent to be received.")
      return
    }

    switch receivedIntent {
    case .openArticles:
      break
    }
  }

  func test_setIntentHandler_replacesHandler() {
    var firstHandlerCalls = 0
    var secondHandlerCalls = 0
    let sut = FeedViewModel(
      title: "Feed",
      subtitle: "Subtitle",
      intentHandler: { _ in firstHandlerCalls += 1 }
    )

    sut.setIntentHandler { _ in
      secondHandlerCalls += 1
    }
    sut.openArticles()

    XCTAssertEqual(firstHandlerCalls, 0)
    XCTAssertEqual(secondHandlerCalls, 1)
  }
}
