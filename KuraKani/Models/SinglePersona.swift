//
//  SinglePersona.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-07-09.
//

import SwiftData
import SwiftUI

@Observable
class SinglePersona {
    var id: UUID = .init()
    var name: String = ""
    var description: String = ""
    var icon: Image = .init(systemName: "person.crop.circle")
    var prompt: String = ""
    var chats: [Chats] = []

    init(
        name: String,
        description: String,
        icon: Image,
        prompt: String,
        chats: [Chats] = []
    ) {
        self.name = name
        self.description = description
        self.icon = icon
        self.prompt = prompt
        self.chats = chats
    }

    static let examplePersonas: [SinglePersona] = [
        .init(
            name: "John Doe",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            icon: .init(.greenIcon),
            prompt: "How can I assist you today?",
            chats: Chats.exampleChats
        ),
        .init(
            name: "Jane Smith",
            description: "Nulla fermentum justo a est luctus, sit amet bibendum urna feugiat.",
            icon: .init(.redIcon),
            prompt: "What can I help you with?",
            chats: Chats.exampleChats
        ),
        .init(
            name: "Alex Johnson",
            description: "Praesent vel odio non metus auctor bibendum ut at metus.",
            icon: .init(.blueIcon),
            prompt: "Welcome! How may I assist you?",
            chats: Chats.exampleChats
        ),
        .init(
            name: "Emily Davis",
            description: "Curabitur ac dolor vitae ipsum varius consectetur ac ut erat.",
            icon: .init(.tealIcon),
            prompt: "Hello! How can I be of service?",
            chats: Chats.exampleChats
        ),
        .init(
            name: "Maxwell Wilson",
            description: "Vestibulum in lacus placerat, sollicitudin mi eu, viverra metus.",
            icon: .init(.pinkIcon),
            prompt: "Greetings! How may I help you today?",
            chats: Chats.exampleChats
        )
    ]
}

@Observable
class Chats {
    var id: UUID = .init()
    var title: String = ""
    var singleChats: [SingleChat] = []

    init(title: String, singleChats: [SingleChat]) {
        self.id = UUID()
        self.title = title
        self.singleChats = singleChats
    }

    static let exampleChats: [Chats] = [
        Chats(title: "Chat 1", singleChats: [
            SingleChat("Hello!", role: .human),
            SingleChat("Hi There", role: .computer),
            SingleChat("How are you?", role: .human),
            SingleChat("I'm doing well, thanks!", role: .computer),
            SingleChat("What's new?", role: .human),
            SingleChat("Not much, just working on a project.", role: .computer)
        ]),
        Chats(title: "Chat 2", singleChats: [
            SingleChat("Hey there!", role: .human),
            SingleChat("Yoo! What are you doing?.", role: .computer),
            SingleChat("Not much, just working on a project.", role: .human),
            SingleChat("You need help?", role: .computer),
            SingleChat("Let me know if you have any questions.", role: .computer),
            SingleChat("hello?", role: .computer),
            SingleChat("talk to me human.", role: .computer)
        ])
    ]
}

@Observable
class SingleChat {
    var id: UUID = .init()
    var text: String = ""
    var role: ChatRole = .computer

    var isHuman: Bool {
        role == .human
    }

    var isComputer: Bool {
        role == .computer
    }

    var color: Color {
        role == .computer ? .red : .blue
    }

    init(_ text: String, role: ChatRole) {
        self.id = UUID()
        self.text = text
        self.role = role
    }
}

enum ChatRole: String {
    case computer = "Computer"
    case human = "You"
}

extension SinglePersona: Identifiable, Hashable {
    static func == (lhs: SinglePersona, rhs: SinglePersona) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id.uuidString)
        hasher.combine(name)
    }
}

extension Chats: Identifiable, Hashable {
    static func == (lhs: Chats, rhs: Chats) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id.uuidString)
        hasher.combine(title)
    }
}

extension SingleChat: Identifiable, Hashable {
    static func == (lhs: SingleChat, rhs: SingleChat) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id.uuidString)
        hasher.combine(text)
    }
}
