//
//  ColorInvertModifier.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-07-09.
//

import SwiftUI

// MARK: - ColorInvertModifier

struct ColorInvertModifier: ViewModifier {
    let invert: Bool

    func body(content: Content) -> some View {
        if invert {
            content
                .colorInvert()
        } else {
            content
        }
    }
}

extension View {
    func colorInvert(_ invert: Bool = false) -> ModifiedContent<Self, ColorInvertModifier> {
        return modifier(ColorInvertModifier(invert: invert))
    }
}
