//
//  SplashScreenView.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            Image.kurakani
                .resizable()
                .scaledToFit()
                .frame(width: 128)

            Text("KuraKani")
                .font(.largeTitle.bold())

            Spacer()
            Text("Completely free and opensource.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .preferredColorScheme(.dark)
    }
}
