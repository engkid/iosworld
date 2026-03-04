import Foundation

public protocol HomeModuleBuilding: AnyObject {
  func makeHomeView() -> HomeView
}
