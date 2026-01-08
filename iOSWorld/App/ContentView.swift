//
//  ContentView.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI

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
  
  @StateObject private var viewModel = HomeViewModel()
  
  @State private var query = ""
  private let items = ["iPhone", "iPad", "Mac", "Watch", "AirPods"]
  
  private let navigator: Navigating
  
  var filtered: [String] {
    guard !query.isEmpty else { return items }
    return items.filter { $0.localizedCaseInsensitiveContains(query) }
  }
  
  init(navigator: Navigating) {
    self.navigator = navigator
  }
  
  var body: some View {
    NavigationStack {
      List(filtered, id: \.self) { item in
        Text(item)
      }
      .navigationTitle("Products")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            let destination = ProfileViewController()
            navigator.navigate(to: destination, with: .push)
          } label: {
            Image(systemName: "plus")
          }
        }
        ToolbarItem(placement: .topBarLeading) {
          Button {
            
          } label: {
            Image(systemName: "person")
          }
        }
      }
    }
    .onAppear(perform: {
      viewModel.getPokemonList()
    })
    .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search products")
  }
}

#Preview {
    ContentView(navigator: HomeNavigator())
}

