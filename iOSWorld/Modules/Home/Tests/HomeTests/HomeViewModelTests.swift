import XCTest
import SwiftUI
import Home

final class HomeViewModelTests: XCTestCase {

  func test_openProfile_callsIntentHandler() {
    var receivedIntent: HomeIntent?
    let sut = HomeViewModel(
      title: "Home",
      subtitle: "Subtitle",
      intentHandler: { intent in receivedIntent = intent }
    )

    sut.openProfile()

    guard let receivedIntent else {
      XCTFail("Expected HomeIntent to be received.")
      return
    }

    switch receivedIntent {
    case .openProfile:
      break
    }
  }

  func test_setIntentHandler_replacesHandler() {
    var firstHandlerCalls = 0
    var secondHandlerCalls = 0
    let sut = HomeViewModel(
      title: "Home",
      subtitle: "Subtitle",
      intentHandler: { _ in firstHandlerCalls += 1 }
    )

    sut.setIntentHandler { _ in
      secondHandlerCalls += 1
    }
    sut.openProfile()

    XCTAssertEqual(firstHandlerCalls, 0)
    XCTAssertEqual(secondHandlerCalls, 1)
  }

  func test_makeProfileDestinationView_usesConfiguredBuilder() {
    var builderCalls = 0
    let sut = HomeViewModel(
      title: "Home",
      subtitle: "Subtitle",
      profileDestinationBuilder: {
        builderCalls += 1
        return AnyView(Text("Profile"))
      }
    )

    _ = sut.makeProfileDestinationView()

    XCTAssertEqual(builderCalls, 1)
  }
}
