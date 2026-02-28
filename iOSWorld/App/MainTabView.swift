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
    ZStack(alignment: .bottom) {
      ZStack {
        tabContent(for: viewModel.selectedTab)
      }
      .animation(.spring(response: 0.4, dampingFraction: 0.85), value: viewModel.selectedTab)

      iOSWorldTabView(viewModel: viewModel)
        .padding(.bottom, 8)
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
    tabRouter.makeHomeRoot(homeModuleBuilder: homeModuleBuilder, moduleManager: moduleManager)
      .opacity(tab == .home ? 1 : 0)
      .allowsHitTesting(tab == .home)
    
    FeedTabView()
      .opacity(tab == .feed ? 1 : 0)
      .allowsHitTesting(tab == .feed)
    
    ProfileView()
      .opacity(tab == .profile ? 1 : 0)
      .allowsHitTesting(tab == .profile)
    
    ArticlesTabView()
      .opacity(tab == .articles ? 1 : 0)
      .allowsHitTesting(tab == .articles)
  }

}

// MARK: - move to Feed Module later
private struct FeedTabView: View {
  
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

// MARK: move to Profile Module later
private struct ProfileView: View {
  
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

// MARK: move to Articles Module later
private struct ArticlesTabView: View {
  
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

#Preview {
  MainTabView()
}
