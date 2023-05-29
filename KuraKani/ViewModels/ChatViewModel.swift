//
//  ChatViewModel.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-29, Adapted from https://github.com/MacPaw/OpenAI/
//

import Combine
import KeychainSwift
import OpenAI
import SwiftUI

class ChatViewModel: ObservableObject {
    var openAIClient: OpenAIProtocol?

    @Published var conversations: [Conversation] = []
    @Published var conversationErrors: [Conversation.ID: Error] = [:]
    @Published var selectedConversationID: Conversation.ID?

    var selectedConversation: Conversation? {
        selectedConversationID.flatMap { id in
            conversations.first { $0.id == id }
        }
    }

    var selectedConversationPublisher: AnyPublisher<Conversation?, Never> {
        $selectedConversationID.receive(on: RunLoop.main).map { id in
            self.conversations.first(where: { $0.id == id })
        }
        .eraseToAnyPublisher()
    }

    func refreshClient() {
        if let apiKey = KeychainSwift().getAPIKey() {
            openAIClient = OpenAI(apiToken: apiKey)
        }
    }

    func idProvider() -> String {
        return UUID().uuidString
    }

    init() {
        refreshClient()
    }

    // MARK: - Events

    func createConversation() {
        let conversation = Conversation(id: idProvider(), messages: [])
        conversations.append(conversation)
    }

    func selectConversation(_ conversationID: Conversation.ID?) {
        selectedConversationID = conversationID
    }

    func deleteConversation(_ conversationID: Conversation.ID) {
        conversations.removeAll(where: { $0.id == conversationID })
    }

    @MainActor
    func sendMessage(
        _ message: Message,
        conversationID: Conversation.ID,
        model: Model
    ) async {
        guard let conversationIndex = conversations.firstIndex(where: { $0.id == conversationID }) else {
            return
        }
        conversations[conversationIndex].messages.append(message)

        await completeChat(
            conversationID: conversationID,
            model: model
        )
    }

    @MainActor
    func completeChat(
        conversationID: Conversation.ID,
        model: Model
    ) async {
        guard let client = openAIClient else {
            return
                print("No Client found")
        }
        guard let conversation = conversations.first(where: { $0.id == conversationID }) else {
            return
        }

        conversationErrors[conversationID] = nil

        do {
            guard let conversationIndex = conversations.firstIndex(where: { $0.id == conversationID }) else {
                return
            }

            let chatsStream: AsyncThrowingStream<ChatStreamResult, Error> = client.chatsStream(
                query: ChatQuery(
                    model: model,
                    messages: conversation.messages.map { message in
                        Chat(role: message.role, content: message.content)
                    }
                )
            )

            for try await partialChatResult in chatsStream {
                for choice in partialChatResult.choices {
                    let existingMessages = conversations[conversationIndex].messages
                    let message = Message(
                        id: partialChatResult.id,
                        role: choice.delta.role ?? .assistant,
                        content: choice.delta.content ?? "",
                        createdAt: Date(timeIntervalSince1970: TimeInterval(partialChatResult.created))
                    )
                    if let existingMessageIndex = existingMessages.firstIndex(where: { $0.id == partialChatResult.id }) {
                        // Meld into previous message
                        let previousMessage = existingMessages[existingMessageIndex]
                        let combinedMessage = Message(
                            id: message.id, // id stays the same for different deltas
                            role: message.role,
                            content: previousMessage.content + message.content,
                            createdAt: message.createdAt
                        )
                        conversations[conversationIndex].messages[existingMessageIndex] = combinedMessage
                    } else {
                        conversations[conversationIndex].messages.append(message)
                    }
                }
            }
        } catch {
            conversationErrors[conversationID] = error
        }
    }
}
