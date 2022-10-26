//
//  UserDefaultsSerializer.swift
//  UsefulPractics
//
//  Created by Alexandr on 25.10.2022.
//

import Foundation

protocol UserDefaultsSerializerInterface {
    static func encode<T: Encodable>(value: T) -> Any?
    static func decode<T: Decodable>(value: Any?) -> T?
}

enum UserDefaultsObjectSerializer {
    case jsonData

    var serializerType: UserDefaultsSerializerInterface.Type {
        switch self {
        case .jsonData:
            return UserDefaultsSerializer.self
        }
    }
}

struct UserDefaultsSerializer: UserDefaultsSerializerInterface {
    static func encode<T: Encodable>(value: T) -> Any? {
        guard let encodedData = try? JSONEncoder().encode(value) else {
            return nil
        }
             
        return encodedData
    }
    
    static func decode<T: Decodable>(value: Any?) -> T? {
        guard let value else {
            return nil
        }
        
        guard
            let data = value as? Data,
            let result = try? JSONDecoder().decode(T.self, from: data)
        else {
            return nil
        }
        
        return result
    }
}
