//
//  PersonaDetails.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-07-10.
//

import SwiftUI

struct PersonaDetails: View {
    let persona: SinglePersona
    var body: some View {
        ScrollView {
            VStack {
                ForEach(persona.chats) { chats in
                    NavigationLink {
                        ChatDetail(chat: chats)
                    } label: {
                        ChatsRow(chats: chats)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .navigationTitle(persona.name)
    }
}

#Preview {
    NavigationStack {
        PersonaDetails(persona: .examplePersonas.first!)
            .preferredColorScheme(.dark)
    }
}
