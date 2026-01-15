import SwiftUI

struct TnCTextView: View {
    var body: some View {
        Text(makeTnCAttributedString())
            .font(.footnote)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.leading)
            .tint(.blue) // hyperlink color
            .padding()
    }

    private func makeTnCAttributedString() -> AttributedString {
        var str = AttributedString("By continuing, you agree to our Terms & Conditions and Privacy Policy. This includes consent to the processing of your personal data for providing and improving our services, delivering personalized content and recommendations, and communicating with you about updates, promotional offers, and policy changes. You acknowledge that your use of the app is subject to our Acceptable Use Policy, Community Guidelines, and applicable laws. If you do not agree, you should discontinue use immediately. For more information about how we collect, use, and share information, please review our Privacy Policy and Cookie Policy. You can manage your preferences at any time in Settings. For assistance, visit our Help Center or contact Support. By tapping Continue, you confirm that you are at least 13 years old (or the minimum age required in your region) and you accept the latest versions of these terms.")

        // Base styling for the whole paragraph
        str.font = .system(.footnote)
        str.foregroundColor = .secondary

        // Emphasize opening clause
        if let range = str.range(of: "By continuing") {
            str[range].font = .system(.footnote, design: .default).bold()
            str[range].foregroundColor = .primary
        }

        // Link: Terms & Conditions
        if let range = str.range(of: "Terms & Conditions") {
            str[range].link = URL(string: "https://example.com/terms")!
            str[range].font = .system(.footnote).weight(.semibold)
        }

        // Link: Privacy Policy (first occurrence)
        if let range = str.range(of: "Privacy Policy") {
            str[range].link = URL(string: "https://example.com/privacy")!
            str[range].font = .system(.footnote).weight(.semibold)
        }

        // Link: Acceptable Use Policy
        if let range = str.range(of: "Acceptable Use Policy") {
            str[range].link = URL(string: "https://example.com/acceptable-use")!
            str[range].font = .system(.footnote).weight(.semibold)
        }

        // Link: Community Guidelines
        if let range = str.range(of: "Community Guidelines") {
            str[range].link = URL(string: "https://example.com/guidelines")!
            str[range].font = .system(.footnote).weight(.semibold)
        }

        // Link: Cookie Policy
        if let range = str.range(of: "Cookie Policy") {
            str[range].link = URL(string: "https://example.com/cookies")!
            str[range].font = .system(.footnote).weight(.semibold)
        }

        // Link: Settings (anchor to app settings docs)
        if let range = str.range(of: "Settings") {
            str[range].link = URL(string: "https://example.com/settings")!
            str[range].font = .system(.footnote).weight(.semibold)
        }

        // Link: Help Center
        if let range = str.range(of: "Help Center") {
            str[range].link = URL(string: "https://example.com/help")!
            str[range].font = .system(.footnote).weight(.semibold)
        }

        // Link: Support
        if let range = str.range(of: "Support") {
            str[range].link = URL(string: "https://example.com/support")!
            str[range].font = .system(.footnote).weight(.semibold)
        }

        // Emphasize the age confirmation and action
        if let range = str.range(of: "By tapping Continue") {
            str[range].font = .system(.footnote).weight(.semibold)
            str[range].foregroundColor = .primary
        }

        return str
    }
}