//
//  HomeView.swift
//  Home
//
//  Created by Engkit Riswara on 24/02/26.
//

import SwiftUI

public struct HomeView: View {
  @StateObject private var viewModel: HomeViewModel

  public init(viewModel: HomeViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  public var body: some View {
    VStack(spacing: 16) {
      Text(viewModel.title)
        .font(.largeTitle.weight(.bold))
      Text(viewModel.subtitle)
        .font(.body)
        .foregroundStyle(.secondary)
      NavigationLink("Go to Home Detail") {
        HomeDetailView(viewModel: viewModel)
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
  }
}

private struct HomeDetailView: View {
  let viewModel: HomeViewModel

  var body: some View {
    VStack(spacing: 16) {
      Text("Home Detail")
        .font(.title.bold())
      Text("This detail page can request cross-module navigation.")
        .font(.body)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
      NavigationLink("Open Profile Module") {
        viewModel.makeProfileDestinationView()
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.horizontal, 24)
    .background(Color(.systemGroupedBackground))
  }
}
