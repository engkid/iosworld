//
//  HomeView.swift
//  Home
//
//  Created by Engkit Riswara on 24/02/26.
//

import SwiftUI

public struct HomeView: View {
  @StateObject private var viewModel: HomeViewModel
  @State private var isHomeDetailPresented = false

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
      Button("Go to Home Detail") {
        isHomeDetailPresented = true
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
    .navigationDestination(isPresented: $isHomeDetailPresented) {
      HomeDetailView(viewModel: viewModel)
    }
  }
}
