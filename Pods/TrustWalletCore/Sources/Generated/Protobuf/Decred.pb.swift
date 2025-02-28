// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: Decred.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// A transfer transaction
public struct TW_Decred_Proto_Transaction {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Serialization format
  public var serializeType: UInt32 = 0

  /// Transaction data format version
  public var version: UInt32 = 0

  /// A list of 1 or more transaction inputs or sources for coins.
  public var inputs: [TW_Decred_Proto_TransactionInput] = []

  /// A list of 1 or more transaction outputs or destinations for coins
  public var outputs: [TW_Decred_Proto_TransactionOutput] = []

  /// The time when a transaction can be spent (usually zero, in which case it has no effect).
  public var lockTime: UInt32 = 0

  /// The block height at which the transaction expires and is no longer valid.
  public var expiry: UInt32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Decred transaction input.
public struct TW_Decred_Proto_TransactionInput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Reference to the previous transaction's output.
  public var previousOutput: TW_Bitcoin_Proto_OutPoint {
    get {return _previousOutput ?? TW_Bitcoin_Proto_OutPoint()}
    set {_previousOutput = newValue}
  }
  /// Returns true if `previousOutput` has been explicitly set.
  public var hasPreviousOutput: Bool {return self._previousOutput != nil}
  /// Clears the value of `previousOutput`. Subsequent reads from it will return its default value.
  public mutating func clearPreviousOutput() {self._previousOutput = nil}

  /// Transaction version as defined by the sender.
  public var sequence: UInt32 = 0

  /// The amount of the input
  public var valueIn: Int64 = 0

  /// Creation block height
  public var blockHeight: UInt32 = 0

  /// Index within the block
  public var blockIndex: UInt32 = 0

  /// Computational script for confirming transaction authorization.
  public var script: Data = Data()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _previousOutput: TW_Bitcoin_Proto_OutPoint? = nil
}

/// Decred transaction output.
public struct TW_Decred_Proto_TransactionOutput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Transaction amount.
  public var value: Int64 = 0

  /// Transaction output version.
  public var version: UInt32 = 0

  /// Usually contains the public key as a Decred script setting up conditions to claim this output.
  public var script: Data = Data()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Result containing the signed and encoded transaction.
public struct TW_Decred_Proto_SigningOutput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Resulting transaction. Note that the amount may be different than the requested amount to account for fees and available funds.
  public var transaction: TW_Decred_Proto_Transaction {
    get {return _storage._transaction ?? TW_Decred_Proto_Transaction()}
    set {_uniqueStorage()._transaction = newValue}
  }
  /// Returns true if `transaction` has been explicitly set.
  public var hasTransaction: Bool {return _storage._transaction != nil}
  /// Clears the value of `transaction`. Subsequent reads from it will return its default value.
  public mutating func clearTransaction() {_uniqueStorage()._transaction = nil}

  /// Signed and encoded transaction bytes.
  public var encoded: Data {
    get {return _storage._encoded}
    set {_uniqueStorage()._encoded = newValue}
  }

  /// Transaction id
  public var transactionID: String {
    get {return _storage._transactionID}
    set {_uniqueStorage()._transactionID = newValue}
  }

  /// Optional error
  public var error: TW_Common_Proto_SigningError {
    get {return _storage._error}
    set {_uniqueStorage()._error = newValue}
  }

  public var errorMessage: String {
    get {return _storage._errorMessage}
    set {_uniqueStorage()._errorMessage = newValue}
  }

  /// Result of a transaction signing using the Bitcoin 2.0 protocol.
  /// Set if `Bitcoin.Proto.SigningInput.signing_v2` used.
  public var signingResultV2: TW_BitcoinV2_Proto_SigningOutput {
    get {return _storage._signingResultV2 ?? TW_BitcoinV2_Proto_SigningOutput()}
    set {_uniqueStorage()._signingResultV2 = newValue}
  }
  /// Returns true if `signingResultV2` has been explicitly set.
  public var hasSigningResultV2: Bool {return _storage._signingResultV2 != nil}
  /// Clears the value of `signingResultV2`. Subsequent reads from it will return its default value.
  public mutating func clearSigningResultV2() {_uniqueStorage()._signingResultV2 = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "TW.Decred.Proto"

extension TW_Decred_Proto_Transaction: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Transaction"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "serializeType"),
    2: .same(proto: "version"),
    3: .same(proto: "inputs"),
    4: .same(proto: "outputs"),
    5: .same(proto: "lockTime"),
    6: .same(proto: "expiry"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self.serializeType) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self.version) }()
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.inputs) }()
      case 4: try { try decoder.decodeRepeatedMessageField(value: &self.outputs) }()
      case 5: try { try decoder.decodeSingularUInt32Field(value: &self.lockTime) }()
      case 6: try { try decoder.decodeSingularUInt32Field(value: &self.expiry) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.serializeType != 0 {
      try visitor.visitSingularUInt32Field(value: self.serializeType, fieldNumber: 1)
    }
    if self.version != 0 {
      try visitor.visitSingularUInt32Field(value: self.version, fieldNumber: 2)
    }
    if !self.inputs.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.inputs, fieldNumber: 3)
    }
    if !self.outputs.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.outputs, fieldNumber: 4)
    }
    if self.lockTime != 0 {
      try visitor.visitSingularUInt32Field(value: self.lockTime, fieldNumber: 5)
    }
    if self.expiry != 0 {
      try visitor.visitSingularUInt32Field(value: self.expiry, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Decred_Proto_Transaction, rhs: TW_Decred_Proto_Transaction) -> Bool {
    if lhs.serializeType != rhs.serializeType {return false}
    if lhs.version != rhs.version {return false}
    if lhs.inputs != rhs.inputs {return false}
    if lhs.outputs != rhs.outputs {return false}
    if lhs.lockTime != rhs.lockTime {return false}
    if lhs.expiry != rhs.expiry {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Decred_Proto_TransactionInput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TransactionInput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "previousOutput"),
    2: .same(proto: "sequence"),
    3: .same(proto: "valueIn"),
    4: .same(proto: "blockHeight"),
    5: .same(proto: "blockIndex"),
    6: .same(proto: "script"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._previousOutput) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self.sequence) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.valueIn) }()
      case 4: try { try decoder.decodeSingularUInt32Field(value: &self.blockHeight) }()
      case 5: try { try decoder.decodeSingularUInt32Field(value: &self.blockIndex) }()
      case 6: try { try decoder.decodeSingularBytesField(value: &self.script) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._previousOutput {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if self.sequence != 0 {
      try visitor.visitSingularUInt32Field(value: self.sequence, fieldNumber: 2)
    }
    if self.valueIn != 0 {
      try visitor.visitSingularInt64Field(value: self.valueIn, fieldNumber: 3)
    }
    if self.blockHeight != 0 {
      try visitor.visitSingularUInt32Field(value: self.blockHeight, fieldNumber: 4)
    }
    if self.blockIndex != 0 {
      try visitor.visitSingularUInt32Field(value: self.blockIndex, fieldNumber: 5)
    }
    if !self.script.isEmpty {
      try visitor.visitSingularBytesField(value: self.script, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Decred_Proto_TransactionInput, rhs: TW_Decred_Proto_TransactionInput) -> Bool {
    if lhs._previousOutput != rhs._previousOutput {return false}
    if lhs.sequence != rhs.sequence {return false}
    if lhs.valueIn != rhs.valueIn {return false}
    if lhs.blockHeight != rhs.blockHeight {return false}
    if lhs.blockIndex != rhs.blockIndex {return false}
    if lhs.script != rhs.script {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Decred_Proto_TransactionOutput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TransactionOutput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
    2: .same(proto: "version"),
    3: .same(proto: "script"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.value) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self.version) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self.script) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.value != 0 {
      try visitor.visitSingularInt64Field(value: self.value, fieldNumber: 1)
    }
    if self.version != 0 {
      try visitor.visitSingularUInt32Field(value: self.version, fieldNumber: 2)
    }
    if !self.script.isEmpty {
      try visitor.visitSingularBytesField(value: self.script, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Decred_Proto_TransactionOutput, rhs: TW_Decred_Proto_TransactionOutput) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.version != rhs.version {return false}
    if lhs.script != rhs.script {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Decred_Proto_SigningOutput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".SigningOutput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "transaction"),
    2: .same(proto: "encoded"),
    3: .standard(proto: "transaction_id"),
    4: .same(proto: "error"),
    5: .standard(proto: "error_message"),
    6: .standard(proto: "signing_result_v2"),
  ]

  fileprivate class _StorageClass {
    var _transaction: TW_Decred_Proto_Transaction? = nil
    var _encoded: Data = Data()
    var _transactionID: String = String()
    var _error: TW_Common_Proto_SigningError = .ok
    var _errorMessage: String = String()
    var _signingResultV2: TW_BitcoinV2_Proto_SigningOutput? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _transaction = source._transaction
      _encoded = source._encoded
      _transactionID = source._transactionID
      _error = source._error
      _errorMessage = source._errorMessage
      _signingResultV2 = source._signingResultV2
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularMessageField(value: &_storage._transaction) }()
        case 2: try { try decoder.decodeSingularBytesField(value: &_storage._encoded) }()
        case 3: try { try decoder.decodeSingularStringField(value: &_storage._transactionID) }()
        case 4: try { try decoder.decodeSingularEnumField(value: &_storage._error) }()
        case 5: try { try decoder.decodeSingularStringField(value: &_storage._errorMessage) }()
        case 6: try { try decoder.decodeSingularMessageField(value: &_storage._signingResultV2) }()
        default: break
        }
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every if/case branch local when no optimizations
      // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
      // https://github.com/apple/swift-protobuf/issues/1182
      try { if let v = _storage._transaction {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      } }()
      if !_storage._encoded.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._encoded, fieldNumber: 2)
      }
      if !_storage._transactionID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._transactionID, fieldNumber: 3)
      }
      if _storage._error != .ok {
        try visitor.visitSingularEnumField(value: _storage._error, fieldNumber: 4)
      }
      if !_storage._errorMessage.isEmpty {
        try visitor.visitSingularStringField(value: _storage._errorMessage, fieldNumber: 5)
      }
      try { if let v = _storage._signingResultV2 {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      } }()
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Decred_Proto_SigningOutput, rhs: TW_Decred_Proto_SigningOutput) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._transaction != rhs_storage._transaction {return false}
        if _storage._encoded != rhs_storage._encoded {return false}
        if _storage._transactionID != rhs_storage._transactionID {return false}
        if _storage._error != rhs_storage._error {return false}
        if _storage._errorMessage != rhs_storage._errorMessage {return false}
        if _storage._signingResultV2 != rhs_storage._signingResultV2 {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
