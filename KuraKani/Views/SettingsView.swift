//
//  SettingsView.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-26.
//

import Colorful
import Defaults
import KeychainSwift
import Setting
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var chatVM: ChatViewModel
    @Environment(\.openURL) var openURL
    @Default(.haptic) var haptic
    @Default(.crashReport) var crashReport
    @Default(.saveConversation) var saveConversation
    @Default(.conversations) var conversations

    @State private var confirmDelete: Bool = false
    @State private var apiKey: String = ""

    var body: some View {
        SettingStack {
            SettingPage(title: "KuraKani Settings") {
                SettingCustomView {
                    VStack {}
                        .padding(.top)
                }

                if KeychainSwift().hasAPIKey() {
                    MonthlyUsageCost
                }

                OpenAiAPIKey

                ChatInfo

                TelemetryInfo

                SettingGroup(header: "Other") {
                    SettingButton(title: "Github Repository") {
                        openURL(
                            .init(string: "https://github.com/Aayush9029/kurakani")!
                        )
                    }
                    SettingButton(title: "Developer Profile") {
                        openURL(
                            .init(string: "https://github.com/Aayush9029")!
                        )
                    }
                    SettingButton(title: "Apps by Developer") {
                        openURL(
                            .init(string: "https://apps.apple.com/us/developer/aayush-pokharel/id1532440924")!
                        )
                    }
                }
            }
        }
        .environment(\.settingBackgroundColor, .backgroundColor)
        .preferredColorScheme(.dark)
        .alert(isPresented: $confirmDelete) {
            Alert(
                title: Text("Delete Chat History"),
                message: Text("Are you sure you want to delete all chat history?"),
                primaryButton: .destructive(Text("Delete All")) {
                    Defaults.clearHistory()
                },
                secondaryButton: .cancel()
            )
        }
    }

    var MonthlyUsageCost: SettingCustomView {
        SettingCustomView(titleForSearch: "API Usage") {
            VStack {
                HStack {
                    Spacer()
                    Text("$0.092")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                }
                Text("API Usage this month")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(
                ColorfulView()
            )
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.quaternary, lineWidth: 2)
            )
            .padding(.horizontal)
        }
    }

    var OpenAiAPIKey: SettingGroup {
        SettingGroup(header: "API Token") {
            SettingCustomView(
                id: "App.Tokens",
                titleForSearch: "API Key"
            ) {
                VStack(alignment: .leading) {
                    Label("OpenAPI Key", systemImage: "key.fill")
                    SecureField("Your API Key for OpenAI",
                                text: $apiKey)
                        .autocorrectionDisabled()
                        .textCase(.none)

                    Button("Save") {
                        KeychainSwift().setAPIKey(apiKey)
                        chatVM.refreshClient()
                    }
                    .disabled(apiKey.isEmpty)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(.gray.opacity(apiKey.isEmpty ? 0.125 : 0.5))
                    .cornerRadius(12)
                    .buttonStyle(.plain)
                }
                .padding()
                .onAppear {
                    if let key = KeychainSwift().getAPIKey() {
                        apiKey = key
                    }
                }
            }
        }
    }

    var ChatInfo: SettingGroup {
        SettingGroup(header: "Chat") {
            SettingCustomView(
                id: "app.haptics",
                titleForSearch: "Haptics"
            ) {
                LabeledToggle(
                    "Use haptics",
                    symbol: haptic ? "water.waves" : "water.waves.slash",
                    value: $haptic
                )
            }
            SettingCustomView(
                id: "chat.history",
                titleForSearch: "Chat History"
            ) {
                LabeledToggle(
                    "Save Chat History",
                    symbol: saveConversation ? "text.badge.plus" : "text.badge.minus",
                    value: $saveConversation
                )

                if saveConversation {
                    Button(role: .destructive) {
                        confirmDelete.toggle()
                    } label: {
                        Label(
                            conversations.messages.isEmpty ?
                                "Chat History is Empty" :
                                "Delete Chat History",
                            systemImage: "trash"
                        )
                    }
                    .padding()
                    .disabled(conversations.messages.isEmpty)
                }
            }
        }
    }

    var TelemetryInfo: SettingGroup {
        SettingGroup(header: "Telemetry") {
            SettingCustomView(
                id: "telemetry.crashreport",
                titleForSearch: "Report"
            ) {
                LabeledToggle("Send Crash Report", symbol: "exclamationmark.triangle", value: $crashReport)
            }
        }
    }
}

struct LabeledToggle: View {
    let title: String
    let symbol: String
    @Binding var value: Bool

    init(_ title: String, symbol: String, value: Binding<Bool>) {
        self.title = title
        self.symbol = symbol
        self._value = value
    }

    var body: some View {
        HStack {
            Image(systemName: symbol)
            Text(title)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            Toggle("", isOn: $value)
                .labelsHidden()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct BluredGradient: View {
    @State private var animate: Bool = false

    let startRadius: CGFloat = 0
    let endRadius: CGFloat = 128

    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.blue, .blue.opacity(animate ? 0.25 : 0)],
                center: .bottomLeading,
                startRadius: startRadius,
                endRadius: endRadius
            )
            .offset(y: animate ? 0 : 85)
            RadialGradient(
                colors: [.red, .red.opacity(animate ? 0.25 : 0)],
                center: .topTrailing,
                startRadius: startRadius,
                endRadius: endRadius
            ).offset(y: animate ? 95 : 0)

            RadialGradient(
                colors: [animate ? .yellow : .yellow, .yellow.opacity(animate ? 0.25 : 0)],
                center: .topLeading,
                startRadius: startRadius,
                endRadius: endRadius
            )
        }
        .blur(radius: 32)
        .background(.black)
        .onAppear {
            withAnimation(.easeIn(duration: 5).repeatForever(autoreverses: true)) {
                animate.toggle()
            }
        }
    }
}
