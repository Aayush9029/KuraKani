//
//  KuraKaniApp.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import SwiftUI

@main
struct KuraKaniApp: App {
    @State private var showCover: Bool = true
    var body: some Scene {
        WindowGroup {
            ContentView()
                .fullScreenCover(isPresented: $showCover) {
                    SplashScreenView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showCover = false
                            }
                        }
                }
        }
    }
}
