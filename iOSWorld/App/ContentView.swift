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
  
  @StateObject private var viewModel = HomeViewModel()
  
  @State private var query = ""
  @State private var lastThrottledName = "-"
  @State private var name = ""
  @State private var nameError: FieldError?
  @State private var age = ""
  @State private var ageError: FieldError?
  
  private let items = ["Websocket", "iPad", "Mac", "Watch", "AirPods"]
  
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
      VStack {
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
        
        CustomTextField(
              title: "Name (varchar, max 20)",
              inputType: .varchar(maxLength: 20),
              keyboardLabel: .next,
              onThrottledChange: { value in
                  lastThrottledName = value
                  // Put expensive work here (e.g. server validation, search, analytics)
              },
              text: $name,
              error: $nameError
          )
          .padding(.horizontal, 16)
        
        Spacer()
        
        CustomTextField(
              title: "age (varchar, max 20)",
              inputType: .varchar(maxLength: 20),
              keyboardLabel: .next,
              onThrottledChange: { value in
                  lastThrottledName = value
                  // Put expensive work here (e.g. server validation, search, analytics)
              },
              text: $age,
              error: $ageError
          )
          .padding(.horizontal, 16)
        
        Spacer()
        
        Text("Name: \(lastThrottledName)").frame(alignment: .leading)
        
        TnCTextView()
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .searchableOnAppear($query, prompt: "Search products", placement: .navigationBarDrawer(displayMode: .always)) { queryChanged in
      print("query \(queryChanged)")
    }
  }
}

#Preview {
    ContentView(navigator: HomeNavigator())
}



//// MARK: - Demo usage
//struct CustomTextFieldDemo: View {
//    @State private var name = ""
//    @State private var nameError: FieldError?
//
//    @State private var age = ""
//    @State private var ageError: FieldError?
//
//    @State private var lastThrottledName = "-"
//    @State private var lastThrottledAge = "-"
//
//    // Example of resigning on tap outside
//    @FocusState private var focusedField: Field?
//
//    enum Field { case name, age }
//
//    var body: some View {
//        VStack(spacing: 18) {
//          
//
//          CustomTextField(
//                title: "Age (number)",
//                inputType: .number,
//                keyboardLabel: .done,
//                onThrottledChange: { value in
//                    lastThrottledAge = value
//                },
//                text: $age,
//                error: $ageError
//            )
//            .onTapGesture { focusedField = .age }
//
//            VStack(alignment: .leading, spacing: 6) {
//                Text("Throttled callbacks (debounced):")
//                    .font(.subheadline)
//                    .foregroundStyle(.secondary)
//                Text("Name: \(lastThrottledName)")
//                Text("Age: \(lastThrottledAge)")
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//
//            Button("Validate & Dismiss Keyboard") {
//                nameError = validateName(name)
//                ageError = validateAge(age)
//                // Resign keyboard globally-ish
//                focusedField = nil
//            }
//            .buttonStyle(.borderedProminent)
//
//            Spacer()
//        }
//        .padding(16)
//        .contentShape(Rectangle())
//        .onTapGesture {
//            // Tap outside: resign first responder
//            focusedField = nil
//        }
//    }
//
//    private func validateName(_ value: String) -> FieldError? {
//        value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .empty : nil
//    }
//
//    private func validateAge(_ value: String) -> FieldError? {
//        if value.isEmpty { return .empty }
//        return value.allSatisfy(\.isNumber) ? nil : .notNumber
//    }
//}

