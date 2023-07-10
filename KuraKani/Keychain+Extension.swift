//
//  Keychain+Extension.swift
//  KuraKani
//
//  Created by Aayush Pokharel on 2023-05-28.
//

import KeychainSwift

extension KeychainSwift {
    static let apiKeyIdentifier = "com.aayush.opensource.openaikey"
    static let keychain = KeychainSwift()

    func setAPIKey(_ key: String) {
        KeychainSwift.keychain.set(key, forKey: KeychainSwift.apiKeyIdentifier)
    }

    func getAPIKey() -> String? {
        return KeychainSwift.keychain.get(KeychainSwift.apiKeyIdentifier)
    }

    func resetAPIKey() {
        KeychainSwift.keychain.delete(KeychainSwift.apiKeyIdentifier)
    }

    func hasAPIKey() -> Bool {
        return getAPIKey() != nil
    }
}
