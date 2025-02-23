/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A custom button style for prominent buttons that the app displays.
*/

import SwiftUI

/// `ProminentButtonStyle` is a custom button style that encapsulates
/// all the common modifiers for prominent buttons that the app displays.
struct ProminentButtonStyle: ButtonStyle {

    /// The color scheme of the environment.
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    var isSelected: Bool

    /// Applies relevant modifiers for this button style.
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .font(.title3.bold())
            .foregroundColor(.primary)
            .padding()
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))

            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(isSelected ? .primary : Color.clear, lineWidth: 3)
                    .padding(1.5)
            )
    }
}

// MARK: - Button style extension

/// An extension that offers more convenient and idiomatic syntax to apply
/// the prominent button style to a button.
extension ButtonStyle where Self == ProminentButtonStyle {

    /// A button style that encapsulates all the common modifiers
    /// for prominent buttons shown in the UI.
    static var prominent: ProminentButtonStyle {
        ProminentButtonStyle(isSelected: false)
    }

    static func prominent(isSelected: Bool) -> ProminentButtonStyle {
        ProminentButtonStyle(isSelected: isSelected)
    }
}
