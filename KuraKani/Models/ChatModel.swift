//
//  ChatModel.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import Defaults
import Foundation

enum ChatRole {
    case user
    case assistant
    case system
}

struct ChatModel {
    var id: String
    var role: ChatRole
    var content: String
    var createdAt: Date

    static let example: ChatModel = .init(
        id: UUID().uuidString,
        role: .system,
        content: "Hello World!",
        createdAt: .now
    )
}

struct AllChats {
    let id: String
    var chats: [ChatModel]
}

extension ChatRole: Codable, Defaults.Serializable {}
extension ChatModel: Codable, Identifiable, Defaults.Serializable {}
extension AllChats: Codable, Identifiable, Defaults.Serializable {}
