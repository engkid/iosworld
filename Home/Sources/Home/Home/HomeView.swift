//
//  HomeView.swift
//  Home
//
//  Created by Engkit Riswara on 24/02/26.
//

import SwiftUI
import Factory

public struct HomeView: View {
  @StateObject private var viewModel: HomeViewModel

  public init() {
    _viewModel = StateObject(wrappedValue: Container.shared.homeViewModel())
  }

  public var body: some View {
    VStack(spacing: 16) {
      Text(viewModel.title)
        .font(.largeTitle.weight(.bold))
      Text(viewModel.subtitle)
        .font(.body)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
  }
}
