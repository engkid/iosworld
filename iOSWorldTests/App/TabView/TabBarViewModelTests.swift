import Testing
@testable import iOSWorld

struct TabBarViewModelTests {

  @Test
  func init_setsDefaultSelectionAndItems() {
    let viewModel = TabBarViewModel()

    #expect(viewModel.selectedTab == .home)
    #expect(viewModel.items.count == TabItem.allCases.count)
    #expect(viewModel.items.filter(\.isSelected).count == 1)
    #expect(viewModel.items.first(where: { $0.tab == .home })?.isSelected == true)
  }

  @Test
  func select_updatesSelectedTabAndItems() {
    let viewModel = TabBarViewModel(defaultTab: .home)

    viewModel.select(.articles)

    #expect(viewModel.selectedTab == .articles)
    #expect(viewModel.items.filter(\.isSelected).count == 1)
    #expect(viewModel.items.first(where: { $0.tab == .articles })?.isSelected == true)
    #expect(viewModel.items.first(where: { $0.tab == .home })?.isSelected == false)
  }

  @Test
  func select_sameTab_keepsStateStable() {
    let viewModel = TabBarViewModel(defaultTab: .feed)
    let before = viewModel.items

    viewModel.select(.feed)

    #expect(viewModel.selectedTab == .feed)
    #expect(viewModel.items == before)
  }
}
