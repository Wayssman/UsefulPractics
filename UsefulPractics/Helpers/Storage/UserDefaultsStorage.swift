//
//  UserDefaultsStorage.swift
//  UsefulPractics
//
//  Created by Alexandr on 25.10.2022.
//

import Foundation

@propertyWrapper
final class UserDefaultsStorage<Value: Codable> {
    // MARK: Properties
    let storage: UserDefaults
    let key: String
    let defaultValue: Value
    let serializer: UserDefaultsSerializerInterface.Type?
    var lastValue: Value?  // Prevent reading from UserDefaults each time
    
    var wrappedValue: Value {
        get {
            guard lastValue == nil else {
                return lastValue ?? defaultValue
            }
            
            let storedValue = UserDefaults.standard.value(forKey: key)
            
            guard let serializer else {
                return storedValue as? Value ?? defaultValue
            }
            
            return serializer.decode(value: storedValue) ?? defaultValue
        }
        set {
            defer {
                lastValue = newValue
            }
            
            guard let serializer else {
                UserDefaults.standard.set(newValue, forKey: key)
                return
            }
            
            guard let valueToWrite = serializer.encode(value: newValue) else {
                assertionFailure("Failed to encode serializable value!")
                return
            }
            
            UserDefaults.standard.set(valueToWrite, forKey: key)
        }
    }
    
    init(
        storage: UserDefaults = .standard,
        key: String,
        defaultValue: Value,
        serializer: UserDefaultsSerializerInterface.Type? = nil
    ) {
        self.storage = storage
        self.key = key
        self.defaultValue = defaultValue
        self.lastValue = nil
        self.serializer = serializer
    }
}

// MARK: - ExpressibleByNilLiteral
extension UserDefaultsStorage where Value: ExpressibleByNilLiteral {
    convenience init(
        storage: UserDefaults = .standard,
        key: String,
        serializer: UserDefaultsSerializerInterface.Type? = nil
    ) {
        self.init(
            storage: storage,
            key: key,
            defaultValue: nil,
            serializer: serializer
        )
    }
}
