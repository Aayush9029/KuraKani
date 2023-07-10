//
//  ContentView.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-07-09.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var selectedPersona: SinglePersona?
    @State private var selectedChats: Chats?
    var body: some View {
        NavigationSplitView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(SinglePersona.examplePersonas) { persona in
                        NavigationLink {
                            PersonaDetails(persona: persona)
                        } label: {
                            SinglePersonaRow(persona: persona)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("KuraKani")
        } content: {
            if let selectedPersona {
                PersonaDetails(persona: selectedPersona)
            } else {
                ContentUnavailableView(
                    "Select a persona",
                    systemImage: "person",
                    description: Text(
                        "Select a persona to view"
                    )
                )
            }
        } detail: {
            if let selectedChats {
                ChatsRow(chats: selectedChats)
            } else {
                ContentUnavailableView(
                    "Select a chat",
                    systemImage: "message",
                    description: Text(
                        "Select a chat to view"
                    )
                )
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
