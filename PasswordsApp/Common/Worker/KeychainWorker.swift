//
//  CoreDataService.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/5/22.
//

import Security
import UIKit

class KeychainWorker {

    class func save(key: String, data: Data) -> OSStatus {
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    class func load(key: String) -> Data? {
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            if let result = dataTypeRef as? Data {
                return result
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
}
