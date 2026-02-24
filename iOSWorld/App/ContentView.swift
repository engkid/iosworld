//
//  ContentView.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI
import Home
import Factory

struct ContentView: View {
  @StateObject private var tabBarViewModel = TabBarViewModel()

  var body: some View {
    NavigationStack {
      ZStack(alignment: .bottom) {
        ZStack {
          tabContent(for: tabBarViewModel.selectedTab)
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: tabBarViewModel.selectedTab)

        iOSWorldTabView(viewModel: tabBarViewModel)
          .padding(.bottom, 8)
      }
    }
  }

  @ViewBuilder
  private func tabContent(for tab: TabItem) -> some View {
    switch tab {
    case .home:
      HomeTabView()
    case .feed:
      FeedTabView()
    case .profile:
      ProfileTabView()
    case .articles:
      ArticlesTabView()
    }
  }
}

private struct HomeTabView: View {
  @StateObject private var viewModel: HomeTabViewModel

  init(viewModel: HomeTabViewModel = Container.shared.homeTabViewModel()) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
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

private struct FeedTabView: View {
  @StateObject private var viewModel: FeedTabViewModel

  init(viewModel: FeedTabViewModel = Container.shared.feedTabViewModel()) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
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

private struct ProfileTabView: View {
  @StateObject private var viewModel: ProfileTabViewModel

  @MainActor
  init(viewModel: ProfileTabViewModel = Container.shared.profileTabViewModel()) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
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

private struct ArticlesTabView: View {
  @StateObject private var viewModel: ArticlesTabViewModel

  init(viewModel: ArticlesTabViewModel = Container.shared.articlesTabViewModel()) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
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

#Preview {
  ContentView()
}
