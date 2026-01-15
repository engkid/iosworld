//
//  CustomTextField.swift
//  Home
//
//  Created by Engkit Riswara on 13/01/26.
//

import SwiftUI
import Combine

// MARK: - Input type
public enum InputType {
  case number
  case varchar(maxLength: Int? = nil)
}

// MARK: - Validation
public enum FieldError: String, Identifiable {
  public var id: String { rawValue }
  case empty = "This field can't be empty."
  case notNumber = "Please enter a valid number."
  case tooLong = "Value is too long."
}

@MainActor public final class Throttler: ObservableObject {
  private var task: Task<Void, Never>?
  private let queue = DispatchQueue(label: "Throttler.queue", attributes: .concurrent)
  
  /// Debounce (commonly what people mean by "throttle" for text input): only fire after user stops typing for `delay`.
  func debounce(delay: Duration, _ action: @escaping () -> Void) {
    task?.cancel()
    task = Task {
      // Sleep off the main actor to avoid blocking UI while keeping actor isolation for state
      try? await Task.sleep(for: delay)
      if Task.isCancelled { return }
      // Ensure UI-related closures run on the main actor
      action()
    }
  }
  
  /// True throttle: fire at most once per interval (leading). Useful for analytics / expensive lookups.
  private var lastFire: ContinuousClock.Instant?
  func throttle(interval: Duration, _ action: @escaping () -> Void) {
    var shouldFire = false
    var now: ContinuousClock.Instant!
    queue.sync(flags: .barrier) {
      now = ContinuousClock().now
      if let lastFire, now.duration(to: lastFire) < interval {
        shouldFire = false
      } else {
        self.lastFire = now
        shouldFire = true
      }
    }
    if shouldFire { action() }
  }
}

// MARK: - Reusable field
public struct CustomTextField: View {
  let title: String
  let inputType: InputType
  let keyboardLabel: SubmitLabel
  let onThrottledChange: (String) -> Void
  
  public init(
    title: String,
    inputType: InputType,
    keyboardLabel: SubmitLabel,
    onThrottledChange: @escaping (String) -> Void,
    text: Binding<String>,
    error: Binding<FieldError?> = .constant(nil),
    throttler: Throttler? = nil
  ) {
    self.title = title
    self.inputType = inputType
    self.keyboardLabel = keyboardLabel
    self.onThrottledChange = onThrottledChange
    self._text = text
    self._error = error
    self._throttler = StateObject(wrappedValue: throttler ?? Throttler())
  }
  
  @Binding var text: String
  @Binding var error: FieldError?

  // Resign first responder via FocusState (exposed as a plain Binding for init)
  @FocusState private var isFocused: Bool

  // Debounce/throttle helper
  @StateObject private var throttler: Throttler
  
  // Appearance
  private var borderColor: Color {
    error == nil ? .secondary.opacity(0.4) : .red
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      Text(title)
        .font(.subheadline)
        .foregroundStyle(.secondary)
      
      TextField("", text: Binding(
        get: { text },
        set: { newValue in
          let filtered = filter(newValue, by: inputType)
          text = filtered
          error = validate(filtered, by: inputType)
          
          // "valueChanged throttling" (debounce)
          throttler.debounce(delay: .milliseconds(350)) {
            onThrottledChange(filtered)
          }
        }
      ))
      .textInputAutocapitalization(.never)
      .autocorrectionDisabled(true)
      .keyboardType(keyboardType(for: inputType))
      .submitLabel(keyboardLabel)
      .focused($isFocused)
      .padding(.horizontal, 12)
      .padding(.vertical, 10)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(borderColor, lineWidth: 1)
      )
      .onSubmit {
        // Resign first responder
        isFocused = false
      }
      
      if let error {
        Text(error.rawValue)
          .font(.footnote)
          .foregroundStyle(.red)
      }
    }
  }
  
  // MARK: - Helpers
  private func keyboardType(for inputType: InputType) -> UIKeyboardType {
    switch inputType {
    case .number: return .numberPad
    case .varchar: return .default
    }
  }
  
  private func filter(_ value: String, by type: InputType) -> String {
    switch type {
    case .number:
      // Keep digits only
      return value.filter(\.isNumber)
    case .varchar(let maxLength):
      if let maxLength, value.count > maxLength {
        return String(value.prefix(maxLength))
      }
      return value
    }
  }
  
  private func validate(_ value: String, by type: InputType) -> FieldError? {
    if value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      return .empty
    }
    switch type {
    case .number:
      return value.allSatisfy(\.isNumber) ? nil : .notNumber
    case .varchar(let maxLength):
      if let maxLength, value.count > maxLength { return .tooLong }
      return nil
    }
  }
}

