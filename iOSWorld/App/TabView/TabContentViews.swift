//
//  TabContentViews.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 03/03/26.
//

import SwiftUI
import Factory

struct FeedTabView: View {

  @InjectedObject(\.feedViewModel) var viewModel

  var body: some View {
    NavigationStack {
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
}

struct ProfileTabView: View {

  @InjectedObject(\.profileViewModel) var viewModel

  var body: some View {
    NavigationStack {
      VStack(spacing: 16) {
        Text(viewModel.title)
          .font(.largeTitle.weight(.bold))
        Text(viewModel.subtitle)
          .font(.body)
          .foregroundStyle(.secondary)
        NavigationLink("Go to Profile Detail") {
          ProfileDetailView()
        }
        .buttonStyle(.borderedProminent)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(.systemGroupedBackground))
    }
  }
}

struct ArticlesTabView: View {

  @InjectedObject(\.articlesViewModel) var viewModel

  var body: some View {
    NavigationStack {
      VStack(spacing: 16) {
        Text(viewModel.title)
          .font(.largeTitle.weight(.bold))
        Text(viewModel.subtitle)
          .font(.body)
          .foregroundStyle(.secondary)
        NavigationLink("Go to Articles Detail") {
          ArticlesDetailView()
        }
        .buttonStyle(.borderedProminent)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(.systemGroupedBackground))
    }
  }
}

private struct FeedDetailView: View {
  var body: some View {
    Text("Feed Detail")
      .font(.title.bold())
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(.systemGroupedBackground))
  }
}

private struct ProfileDetailView: View {
  var body: some View {
    Text("Profile Detail")
      .font(.title.bold())
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(.systemGroupedBackground))
  }
}

private struct ArticlesDetailView: View {
  var body: some View {
    Text("Articles Detail")
      .font(.title.bold())
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(.systemGroupedBackground))
  }
}
