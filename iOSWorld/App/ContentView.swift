//
//  ContentView.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI
import Home

enum NavigationMethod {
  case push
  case present
  case popToRoot
  case replaceRoot
}

struct ProfileView: View {
  
  var body: some View {
    Text("Profile")
  }
}

protocol Navigating {
  func navigate(to destination: UIViewController, with method: NavigationMethod)
}

actor HomeNavigator: Navigating {
  @MainActor
  func navigate(to destination: UIViewController, with method: NavigationMethod) {
    
  }
}

final class ProfileViewController: UIViewController {
  
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let profileSwiftUI = ProfileView()
    let hostingController = UIHostingController(rootView: profileSwiftUI)
    
    addChild(hostingController)
    
    view.addSubview(hostingController.view)
    
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    hostingController.didMove(toParent: self)
  }
  
}

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
  var body: some View {
    VStack(spacing: 16) {
      Text("Home")
        .font(.largeTitle.weight(.bold))
      Text("Welcome back! Explore updates and highlights.")
        .font(.body)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
  }
}

private struct FeedTabView: View {
  var body: some View {
    VStack(spacing: 16) {
      Text("Feed")
        .font(.largeTitle.weight(.bold))
      Text("Your personalized feed appears here.")
        .font(.body)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
  }
}

private struct ProfileTabView: View {
  var body: some View {
    VStack(spacing: 16) {
      Text("Profile")
        .font(.largeTitle.weight(.bold))
      Text("Manage your account and preferences.")
        .font(.body)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
  }
}

private struct ArticlesTabView: View {
  var body: some View {
    VStack(spacing: 16) {
      Text("Articles")
        .font(.largeTitle.weight(.bold))
      Text("Read curated stories and insights.")
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
