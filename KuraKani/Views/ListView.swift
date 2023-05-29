//
//  ListView.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import SwiftUI

struct ListView: View {
    @Binding var conversations: [Conversation]
    @Binding var selectedConversationID: Conversation.ID?

    var body: some View {
        List(
            $conversations,
            editActions: [.delete],
            selection: $selectedConversationID
        ) { $conversation in
            Text(
                conversation.messages.last?.content ?? "New Conversation"
            )
            .lineLimit(2)
        }
        .navigationTitle("Conversations")
    }
}
