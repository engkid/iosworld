import SwiftUI

public struct SearchableOnAppear: ViewModifier {
    @Binding var query: String
    let prompt: String
    let placement: SearchFieldPlacement
    let onSubmit: ((String) -> Void)?
    let onChange: ((String) -> Void)?

    public init(query: Binding<String>,
                prompt: String = "Search",
                placement: SearchFieldPlacement = .navigationBarDrawer(displayMode: .always),
                onSubmit: ((String) -> Void)? = nil,
                onChange: ((String) -> Void)? = nil) {
        self._query = query
        self.prompt = prompt
        self.placement = placement
        self.onSubmit = onSubmit
        self.onChange = onChange
    }

    public func body(content: Content) -> some View {
        content
            .searchable(text: $query, placement: placement, prompt: prompt)
            .modifier(OptionalOnChange(query: $query, action: onChange))
            .modifier(OptionalOnSubmitSearch(currentQuery: { query }, action: onSubmit))
    }
}

private struct OptionalOnChange: ViewModifier {
    @Binding var query: String
    let action: ((String) -> Void)?
    func body(content: Content) -> some View {
        if let action {
            content.onChange(of: query) { oldValue, newValue in
                action(newValue)
            }
        } else {
            content
        }
    }
}

private struct OptionalOnSubmitSearch: ViewModifier {
    let currentQuery: () -> String
    let action: ((String) -> Void)?
    func body(content: Content) -> some View {
        if let action {
            content.onSubmit(of: .search) {
                action(currentQuery())
            }
        } else {
            content
        }
    }
}

public extension View {
    func searchableOnAppear(_ query: Binding<String>,
                            prompt: String = "Search",
                            placement: SearchFieldPlacement = .navigationBarDrawer(displayMode: .always),
                            onSubmit: ((String) -> Void)? = nil,
                            onChange: ((String) -> Void)? = nil) -> some View {
        self.modifier(SearchableOnAppear(query: query, prompt: prompt, placement: placement, onSubmit: onSubmit, onChange: onChange))
    }
}
