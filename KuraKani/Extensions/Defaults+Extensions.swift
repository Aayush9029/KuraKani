//
//  Defaults+Extensions.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import Defaults
import SwiftUI

extension Defaults.Keys {
    static let haptic = Key<Bool>("HAPTIC", default: true)
    static let crashReport = Key<Bool>("SENDCRASHREPORT", default: false)
    static let saveChatHistory = Key<Bool>("SAVECHATHISTORY", default: false)
    static let chatHistory = Key<AllChats>("CHATHISTORY", default: .init(chats: []))
}
