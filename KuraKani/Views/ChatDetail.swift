//
//  ChatDetail.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-07-10.
//

import SwiftUI

struct ChatDetail: View {
    let chat: Chats
    var body: some View {
        ScrollView {
            ForEach(chat.singleChats) { singleChat in
                Text(singleChat.text)
            }
        }
    }
}

#Preview {
    ChatDetail(chat: .exampleChats.first!)
}
