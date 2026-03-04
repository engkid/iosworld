//
//  HomeDetailView.swift
//  Home
//
//  Created by Engkit Riswara on 03/03/26.
//

import Foundation
import SwiftUI

public struct HomeDetailView: View {
  let viewModel: HomeViewModel

  public init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    VStack(spacing: 16) {
      Text("Home Detail")
        .font(.title.bold())
      Text("This detail page behaves like a pushed view controller.")
        .font(.body)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
      Button("Open Profile Module") {
        
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.horizontal, 24)
    .background(Color(.systemGroupedBackground))
  }
}
