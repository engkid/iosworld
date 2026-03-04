//
//  WrapperView.swift
//  Core
//
//  Created by Engkit Riswara on 04/03/26.
//

import Foundation
import SwiftUI
import UIKit

public final class WrapperHolder {
  public weak var viewController: UIViewController?
  
  public init() {}
}

public final class WrapperView<SomeView>: UIHostingController<SomeView>, UIGestureRecognizerDelegate, UINavigationControllerDelegate where SomeView: WrappedView {
  
}

public protocol WrappedView: View {
  var holder: WrapperHolder { get set }
}

public extension WrappedView {
  
  var viewController: UIViewController {
    let viewController = WrapperView(rootView: self)
    self.holder.viewController = viewController
    return viewController
  }
  
}

public struct WrappedNavigationController<SomeView>: UIViewControllerRepresentable where SomeView: WrappedView {
  public let rootView: SomeView

  public init(rootView: SomeView) {
    self.rootView = rootView
  }

  public func makeUIViewController(context: Context) -> UINavigationController {
    UINavigationController(rootViewController: rootView.viewController)
  }

  public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    // Root hosting controller manages SwiftUI updates internally.
  }
}
