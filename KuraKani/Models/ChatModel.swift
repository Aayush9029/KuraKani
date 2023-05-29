//
//  ChatModel.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import Defaults
import Foundation
import OpenAI

struct Message {
    var id: String
    var role: Chat.Role
    var content: String
    var createdAt: Date

    static let example: Message = .init(
        id: UUID().uuidString,
        role: Chat.Role.system,
        content: "Hello World!",
        createdAt: .now
    )
}

struct Conversation {
    let id: String
    var messages: [Message]
}

extension Chat.Role: Defaults.Serializable {}
extension Message: Equatable, Codable, Identifiable, Defaults.Serializable {}
extension Conversation: Equatable, Codable, Identifiable, Defaults.Serializable {}
