//
//  iOSWorldTabView.swift
//  iOSWorld
//
//  Created by Engkit Riswara on 25/02/26.
//

import SwiftUI
import Foundation

struct iOSWorldTabView: View {
  @ObservedObject var viewModel: TabBarViewModel
  
  var body: some View {
    GeometryReader { geometry in
      let itemWidth = (geometry.size.width / CGFloat(TabItem.allCases.count)) - 32

      VStack {
        Spacer()

        HStack(spacing: 14) {
          ForEach(viewModel.items) { item in
            tabButton(for: item, width: itemWidth)
          }
        }
        .padding(.top, 16)
        .padding(.horizontal, 20)
        .padding(.bottom, 4)
        .background(
          RoundedRectangle(cornerRadius: 26, style: .continuous)
            .fill(Color.white)
            .shadow(color: Color.black.opacity(0.12), radius: 12, x: 0, y: 6)
        )
        .frame(maxWidth: .infinity)
      }
    }
  }

  private func tabButton(for item: TabModel, width: CGFloat) -> some View {
    return Button {
      withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
        viewModel.select(item.tab)
      }
    } label: {
      VStack(spacing: 6) {
        Image(systemName: item.iconName)
          .font(.system(size: 18, weight: .semibold))
        Text(item.title)
          .font(.caption.weight(.semibold))
      }
      .foregroundStyle(item.isSelected ? Color.white : Color.black.opacity(0.75))
      .frame(width: width, height: 56)
      .background(
        RoundedRectangle(cornerRadius: 18, style: .continuous)
          .fill(item.isSelected ? Color.black : Color.clear)
          .shadow(color: Color.black.opacity(item.isSelected ? 0.25 : 0), radius: 10, x: 0, y: 6)
      )
      .offset(y: item.isSelected ? -8 : 0)
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  iOSWorldTabView(viewModel: TabBarViewModel())
}
