// Copyright © 2021 Tokenary. All rights reserved.

import Foundation
import WalletCore

struct Ethereum {

    enum Error: Swift.Error {
        case invalidInputData
        case failedToSendTransaction
        case failedToSign
        case keyNotFound
    }

    private let queue = DispatchQueue(label: "Ethereum", qos: .default)
    private init() {}
    
    static let shared = Ethereum()
    
    func sign(data: Data, privateKey: WalletCore.PrivateKey) throws -> String {
        return try sign(data: data, privateKey: privateKey, addPrefix: false)
    }
    
    func signPersonalMessage(data: Data, privateKey: WalletCore.PrivateKey) throws -> String {
        return try sign(data: data, privateKey: privateKey, addPrefix: true)
    }
    
    func recover(signature: Data, message: Data) -> String? {
        guard let hash = prefixedDataHash(data: message),
              let publicKey = PublicKey.recover(signature: signature, message: hash),
              PublicKey.isValid(data: publicKey.data, type: publicKey.keyType) else {
                  return nil
              }
        return CoinType.ethereum.deriveAddressFromPublicKey(publicKey: publicKey)
    }
    
    private func prefixedDataHash(data: Data) -> Data? {
        let prefixString = "\u{19}Ethereum Signed Message:\n" + String(data.count)
        guard let prefixData = prefixString.data(using: .utf8) else { return nil }
        return Hash.keccak256(data: prefixData + data)
    }
    
    private func sign(data: Data, privateKey: WalletCore.PrivateKey, addPrefix: Bool) throws -> String {
        let digest: Data
        if addPrefix {
            guard let prefixedData = prefixedDataHash(data: data) else { throw Error.failedToSign }
            digest = prefixedData
        } else {
            digest = data
        }
        
        guard var signed = privateKey.sign(digest: digest, curve: CoinType.ethereum.curve) else { throw Error.failedToSign }
        signed[64] += 27
        return signed.toPrefixedHexString()
    }
    
    func sign(typedData: String, privateKey: WalletCore.PrivateKey) throws -> String {
        let digest = EthereumAbi.encodeTyped(messageJson: typedData)
        guard var signed = privateKey.sign(digest: digest, curve: CoinType.ethereum.curve) else { throw Error.failedToSign }
        signed[64] += 27
        return signed.toPrefixedHexString()
    }
    
    func send(transaction: Transaction, privateKey: WalletCore.PrivateKey, chain: EthereumNetwork) throws -> String {
        let network = EthereumNetwork.forChain(chain)
        let bytes = try signedTransactionBytes(transaction: transaction, privateKey: privateKey, chain: chain)
        let response = try SendRawTransactionProcedure(network: network, transactionBytes: bytes).call()
        guard let hash = response["result"].string else {
            throw Error.failedToSendTransaction
        }
        return hash
    }
    
    private func signedTransactionBytes(transaction: Transaction, privateKey: WalletCore.PrivateKey, chain: EthereumNetwork) throws -> EthContractCallBytes {
        let network = EthereumNetwork.forChain(chain)
        let senderKey = EthPrivateKey(hex: privateKey.data.hexString)
        let contractAddress = EthAddress(hex: transaction.to)
        let functionCall = BytesFromHexString(hex: transaction.data)
        let bytes: EthContractCallBytes
        if let gasPriceString = transaction.gasPrice {
            let gasPrice = EthNumber(hex: gasPriceString)
            if let gasEstimateString = transaction.gas,
               let transctionCountString = transaction.nonce {
                let gasEstimate = EthNumber(hex: gasEstimateString)
                let transactionCount = EthNumber(hex: transctionCountString)
                
                bytes = EthContractCallBytes(networkID: NetworkID(network: network),
                                             transactionsCount: transactionCount,
                                             gasPrice: gasPrice,
                                             gasEstimate: gasEstimate,
                                             senderKey: senderKey,
                                             contractAddress: contractAddress,
                                             weiAmount: transaction.weiAmount,
                                             functionCall: functionCall)
            } else {
                bytes = EthContractCallBytes(network: network,
                                             gasPrice: gasPrice,
                                             senderKey: senderKey,
                                             contractAddress: contractAddress,
                                             weiAmount: transaction.weiAmount,
                                             functionCall: functionCall)
            }
        } else {
            bytes = EthContractCallBytes(network: network,
                                         senderKey: senderKey,
                                         contractAddress: contractAddress,
                                         weiAmount: transaction.weiAmount,
                                         functionCall: functionCall)
        }
        return bytes
    }
    
    func prepareTransaction(_ transaction: Transaction, chain: EthereumNetwork, completion: @escaping (Transaction) -> Void) {
        var transaction = transaction
        
        if transaction.nonce == nil {
            getNonce(chain: chain, from: transaction.from) { nonce in
                transaction.nonce = nonce
                completion(transaction)
            }
        }
        
        func getGasIfNeeded(gasPrice: String) {
            guard transaction.gas == nil else { return }
            getGas(chain: chain, from: transaction.from, to: transaction.to, gasPrice: gasPrice, weiAmount: transaction.weiAmount, data: transaction.data) { gas in
                transaction.gas = gas
                completion(transaction)
            }
        }
        
        if let gasPrice = transaction.gasPrice {
            getGasIfNeeded(gasPrice: gasPrice)
        } else {
            getGasPrice(chain: chain) { gasPrice in
                transaction.gasPrice = gasPrice
                completion(transaction)
                if let gasPrice = gasPrice {
                    getGasIfNeeded(gasPrice: gasPrice)
                }
            }
        }
        
    }
    
    private func getGas(chain: EthereumNetwork, from: String, to: String, gasPrice: String, weiAmount: EthNumber, data: String, completion: @escaping (String?) -> Void) {
        let network = EthereumNetwork.forChain(chain)
        queue.async {
            let value = (try? weiAmount.value().hexString) ?? ""
            let isZeroValue = value == "" || value == "0x"
            if isZeroValue {
                let gas = try? EthGasEstimate(
                    network: network,
                    senderAddress: EthAddress(hex: from),
                    recipientAddress: EthAddress(hex: to),
                    gasEstimate: EthGasEstimate(
                        network: network,
                        senderAddress: EthAddress(hex: from),
                        recipientAddress: EthAddress(hex: to),
                        gasPrice: EthNumber(hex: gasPrice),
                        contractCall: BytesFromHexString(hex: data)
                    ),
                    gasPrice: EthNumber(hex: gasPrice),
                    contractCall: BytesFromHexString(hex: data)
                ).value().toHexString()
                DispatchQueue.main.async {
                    completion(gas)
                }
            } else {
                let gas = try? EthGasEstimate(
                    network: network,
                    senderAddress: EthAddress(hex: from),
                    recipientAddress: EthAddress(hex: to),
                    gasEstimate: EthGasEstimate(
                        network: network,
                        senderAddress: EthAddress(hex: from),
                        recipientAddress: EthAddress(hex: to),
                        gasPrice: EthNumber(hex: gasPrice),
                        weiAmount: weiAmount,
                        contractCall: BytesFromHexString(hex: data)
                    ),
                    gasPrice: EthNumber(hex: gasPrice),
                    weiAmount: weiAmount,
                    contractCall: BytesFromHexString(hex: data)
                ).value().toHexString()
                DispatchQueue.main.async {
                    completion(gas)
                }
            }
        }
    }
    
    private func getGasPrice(chain: EthereumNetwork, completion: @escaping (String?) -> Void) {
        let network = EthereumNetwork.forChain(chain)
        queue.async {
            let gasPrice = try? EthGasPrice(network: network).value().toHexString()
            DispatchQueue.main.async {
                completion(gasPrice)
            }
        }
    }
    
    private func getNonce(chain: EthereumNetwork, from: String, completion: @escaping (String?) -> Void) {
        let network = EthereumNetwork.forChain(chain)
        queue.async {
            let nonce = try? EthTransactions(network: network, address: EthAddress(hex: from), blockChainState: PendingBlockChainState()).count().value().toHexString()
            DispatchQueue.main.async {
                completion(nonce)
            }
        }
    }
    
}
