//
//  ChatModel.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import Defaults
import Foundation

enum ChatUser: Codable, Defaults.Serializable {
    case user
    case gpt
    case app
}

struct ChatModel: Codable, Defaults.Serializable {
    let time: Date
    let message: String
    let user: ChatUser

    static let example: ChatModel = .init(
        time: .now,
        message: "Hello World!",
        user: .app
    )
}

struct AllChats: Codable, Defaults.Serializable {
    var chats: [ChatModel]
}
