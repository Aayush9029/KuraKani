//
//  ContentView.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import KeychainSwift
import OpenAI
import SwiftUI

struct ContentView: View {
    @Environment(\.idProviderValue) var idProvider
    @StateObject var chatVM: ChatViewModel = .init()
    
    var body: some View {
        ChatView(store: self.chatVM)
            .preferredColorScheme(.dark)
            .background(Color.backgroundColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
