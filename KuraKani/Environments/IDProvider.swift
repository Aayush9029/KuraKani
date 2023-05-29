//
//  IDProvider.swift
//  DemoChat
//
//  Created by Sihao Lu on 4/6/23.
//

import SwiftUI

private struct IDProviderKey: EnvironmentKey {
    static let defaultValue: () -> String = {
        UUID().uuidString
    }
}

public extension EnvironmentValues {
    var idProviderValue: () -> String {
        get { self[IDProviderKey.self] }
        set { self[IDProviderKey.self] = newValue }
    }
}

public extension View {
    func idProviderValue(_ idProviderValue: @escaping () -> String) -> some View {
        environment(\.idProviderValue, idProviderValue)
    }
}
