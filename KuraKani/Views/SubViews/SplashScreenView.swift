//
//  SplashScreenView.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Spacer()
            Image(.kurakani)
                .resizable()
                .scaledToFit()
                .colorInvert()
                .frame(width: 128)
                .colorInvert(colorScheme == .dark)

            Text("KuraKani")
                .fontDesign(.serif)
                .font(.largeTitle)

            Spacer()
            Text("Completely free and open-source.")
                .foregroundStyle(.secondary)
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .preferredColorScheme(.dark)
    }
}
