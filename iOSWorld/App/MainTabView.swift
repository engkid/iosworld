//
//  ContentView.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI
import Home
import Factory

@MainActor
struct MainTabView: View {
  
  @InjectedObject(\.tabBarViewModel) var viewModel
  @Injected(\.homeCompositionRoot) var homeModuleBuilder
  @Injected(\.moduleManager) var moduleManager
  @Injected(\.tabRouter) var tabRouter

  var body: some View {
    NavigationStack {
      ZStack(alignment: .bottom) {
        ZStack {
          tabContent(for: viewModel.selectedTab)
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: viewModel.selectedTab)

        iOSWorldTabView(viewModel: viewModel)
          .padding(.bottom, 8)
      }
    }
    .onAppear {
      tabRouter.bindTabSelection { tab in
        viewModel.select(tab)
      }

      moduleManager.setLauncher(tabRouter)
    }
  }

  @ViewBuilder
  private func tabContent(for tab: TabItem) -> some View {
    switch tab {
    case .home:
      homeModuleBuilder.makeHomeView { intent in
        moduleManager.handle(homeIntent: intent)
      } profileDestination: {
        AnyView(ProfileView())
      }
    case .feed:
      FeedTabView()
    case .profile:
      ProfileView()
    case .articles:
      ArticlesTabView()
    }
  }

}

// MARK: - move to Feed Module later
private struct FeedTabView: View {
  
  @InjectedObject(\.feedViewModel) var viewModel

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

// MARK: move to Profile Module later
private struct ProfileView: View {
  
  @InjectedObject(\.profileViewModel) var viewModel

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

// MARK: move to Articles Module later
private struct ArticlesTabView: View {
  
  @InjectedObject(\.articlesViewModel) var viewModel

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
  MainTabView()
}
