//
//  ContentView.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 07/01/26.
//

import SwiftUI

struct ContentView: View {
  
  @State private var query = ""
  private let items = ["iPhone", "iPad", "Mac", "Watch", "AirPods"]
  
  var filtered: [String] {
    guard !query.isEmpty else { return items }
    return items.filter { $0.localizedCaseInsensitiveContains(query) }
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
            
          } label: {
            Image(systemName: "plus")
          }
        }
        ToolbarItem(placement: .topBarLeading) {
          Button {
            
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search products")
  }
}

#Preview {
    ContentView()
}
