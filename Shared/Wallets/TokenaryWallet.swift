// Copyright © 2021 Tokenary. All rights reserved.
// Rewrite of Wallet.swift from Trust Wallet Core.

import Foundation
import WalletCore

final class TokenaryWallet {

    let id: String
    var key: StoredKey
    
    var isMnemonic: Bool {
        return key.isMnemonic
    }

    var accounts = [TokenaryAccount]()
    
    init(id: String, key: StoredKey) {
        self.id = id
        self.key = key
        updateAccounts()
    }

    func updateAccounts() {
        accounts = (0..<key.accountCount).compactMap({ key.account(index: $0) }).map { TokenaryAccount(derivedAccount: $0) }
    }
    
    func createAccount(password: String, coin: CoinType) throws {
        let wallet = key.wallet(password: Data(password.utf8))
        guard key.accountForCoin(coin: coin, wallet: wallet) != nil else { throw KeyStore.Error.invalidPassword }
    }
    
    func createAccount(password: String, coin: CoinType, derivation: Derivation) throws {
        let wallet = key.wallet(password: Data(password.utf8))
        guard key.accountForCoinDerivation(coin: coin, derivation: derivation, wallet: wallet) != nil else { throw KeyStore.Error.invalidPassword }
    }

    func privateKey(password: String, account: TokenaryAccount) throws -> PrivateKey {
        if isMnemonic {
            let wallet = key.wallet(password: Data(password.utf8))
            guard let privateKey = wallet?.getKey(coin: account.coin, derivationPath: account.derivationPath) else { throw KeyStore.Error.invalidPassword }
            return privateKey
        } else {
            guard let privateKey = key.privateKey(coin: account.coin, password: Data(password.utf8)) else { throw KeyStore.Error.invalidPassword }
            return privateKey
        }
    }
    
}

extension TokenaryWallet: Equatable {
    
    static func == (lhs: TokenaryWallet, rhs: TokenaryWallet) -> Bool {
        return lhs.id == rhs.id
    }
    
}

extension TokenaryWallet: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
