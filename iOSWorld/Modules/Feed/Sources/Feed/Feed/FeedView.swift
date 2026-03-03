import SwiftUI

public struct FeedView: View {
  @StateObject private var viewModel: FeedViewModel

  public init(viewModel: FeedViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  public var body: some View {
    VStack(spacing: 16) {
      Text(viewModel.title)
        .font(.largeTitle.weight(.bold))
      Text(viewModel.subtitle)
        .font(.body)
        .foregroundStyle(.secondary)
      NavigationLink("Go to Feed Detail") {
        FeedDetailView()
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
  }
}
