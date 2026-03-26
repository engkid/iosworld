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
  public var navigator: HomeNavigator
  
  @StateObject private var viewModel: HomeViewModel

  public init(holder: WrapperHolder, viewModel: HomeViewModel, navigator: HomeNavigator) {
    _viewModel = StateObject(wrappedValue: viewModel)
    self.navigator = navigator
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
        guard let viewController = holder.viewController else { return }
        navigator.navigate(from: viewController, to: .homeDetail(viewModel))
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
  }
}


