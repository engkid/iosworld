import SwiftUI
import Core

public struct FeedView: WrappedView {
  @StateObject private var viewModel: FeedViewModel
  
  public var holder: WrapperHolder

  public init(holder: WrapperHolder, viewModel: FeedViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
    self.holder = holder
  }

  public var body: some View {
    VStack(spacing: 16) {
      Text(viewModel.title)
        .font(.largeTitle.weight(.bold))
      Text(viewModel.subtitle)
        .font(.body)
        .foregroundStyle(.secondary)
      Button("Go to Feed Detail") {
        let detailController = UIHostingController(rootView: FeedDetailView())
        detailController.hidesBottomBarWhenPushed = true
        detailController.title = "Feed Detail"
        holder.viewController?.navigationController?.pushViewController(detailController, animated: true)
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
  }
}
