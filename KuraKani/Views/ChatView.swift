//
//  ChatView.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Combine
import SwiftUI

struct ChatView: View {
    @ObservedObject var store: ChatViewModel

    @Environment(\.dateProviderValue) var dateProvider
    @Environment(\.idProviderValue) var idProvider

    init(store: ChatViewModel) {
        self.store = store
    }

    var body: some View {
        NavigationSplitView {
            ListView(
                conversations: $store.conversations,
                selectedConversationID: Binding<Conversation.ID?>(
                    get: {
                        store.selectedConversationID
                    }, set: { newID in
                        store.selectConversation(newID)
                    }
                )
            )
            .toolbar {
                ToolbarItem(
                    placement: .primaryAction
                ) {
                    Button(action: {
                        store.createConversation()
                    }) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        } detail: {
            if let conversation = store.selectedConversation {
                DetailView(
                    conversation: conversation,
                    error: store.conversationErrors[conversation.id],
                    sendMessage: { message, selectedModel in
                        Task {
                            await store.sendMessage(
                                Message(
                                    id: idProvider(),
                                    role: .user,
                                    content: message,
                                    createdAt: dateProvider()
                                ),
                                conversationID: conversation.id,
                                model: selectedModel
                            )
                        }
                    }
                )
            }
        }
    }
}
