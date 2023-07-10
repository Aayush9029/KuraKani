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
            VStack(spacing: 12) {
                ForEach(chat.singleChats) { singleChat in
                    HStack {
                        if singleChat.isHuman { Spacer() }
                        Text(singleChat.text)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(singleChat.color.gradient)
                                    .opacity(0.25)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(singleChat.color.opacity(0.5), lineWidth: 1)
                                    )
                            )
                        if singleChat.isComputer { Spacer() }
                    }
                }
            }.padding()
                .navigationTitle(chat.title)
        }
    }
}

#Preview {
    NavigationStack {
        ChatDetail(chat: .exampleChats.last!)
    }
    .preferredColorScheme(.dark)
}
