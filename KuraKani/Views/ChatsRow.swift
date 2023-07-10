//
//  ChatsRow.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-07-10.
//

import SwiftUI

struct ChatsRow: View {
    let chats: Chats
    var body: some View {
        HStack {
            Image(systemName: "message")
                .foregroundStyle(.green)
            Text(chats.title)
                .bold()
            Spacer()
            Text("\(chats.singleChats.count)")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(
            .thinMaterial, in: .rect(cornerRadius: 18)
        )
    }
}

#Preview {
    ChatsRow(chats: .exampleChats.first!)
        .padding()
        .preferredColorScheme(.dark)
}
