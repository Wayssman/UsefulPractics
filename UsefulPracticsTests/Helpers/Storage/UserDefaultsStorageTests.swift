//
//  UserDefaultsStorageTests.swift
//  UsefulPractics
//
//  Created by Alexandr on 27.10.2022.
//

import XCTest
@testable import UsefulPractics

final class UserDefaultsStorageTests: XCTestCase {
    // MARK: Subtypes
    class StoredClass: Codable {
        static let storedObject = StoredClass(
            name: "Alexandr",
            surname: "Zhelanov",
            age: 26
        )
        
        let name: String
        let surname: String
        let age: Int
        
        init(name: String, surname: String, age: Int) {
            self.name = name
            self.surname = surname
            self.age = age
        }
    }
    
    // MARK: Properties
    @UserDefaultsStorage(key: "storedVariableTest", defaultValue: 15)
    var storedVariable: Int
    
    @UserDefaultsStorage(key: "storedObjectTest", serializer: .jsonData)
    var storedObject: StoredClass?
    
    // MARK: Internal
    func testStoredVariable() {
        let expectedValue = 20
        
        storedVariable = 0
        storedVariable = expectedValue
        
        XCTAssertEqual(storedVariable, 20)
    }
    
    func testStoredObject() {
        let expectedValue = StoredClass.storedObject
        
        storedObject = nil
        storedObject = expectedValue
        
        XCTAssertEqual(storedObject!.name, expectedValue.name)
        XCTAssertEqual(storedObject!.surname, expectedValue.surname)
        XCTAssertEqual(storedObject!.age, expectedValue.age)
    }
}
