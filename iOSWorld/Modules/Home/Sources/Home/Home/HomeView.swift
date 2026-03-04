//
//  HomeView.swift
//  Home
//
//  Created by Engkit Riswara on 24/02/26.
//

import SwiftUI
import Core

public struct HomeView: WrappedView {
  public var holder: WrapperHolder
  
  @StateObject private var viewModel: HomeViewModel

  public init(holder: WrapperHolder, viewModel: HomeViewModel) {
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
      Button("Go to Home Detail") {
        let detailController = UIHostingController(rootView: HomeDetailView(viewModel: viewModel))
        holder.viewController?.navigationController?.pushViewController(detailController, animated: true)
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
  }
}
