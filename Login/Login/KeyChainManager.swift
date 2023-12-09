//
//  KeyChainManager.swift
//  login
//
//  Created by pravda on 08.12.2023.
//

import UIKit
import Security

final class KeyChainManager {
    private static let service = "Login"
    
    static func save(email: String, password: String) -> Bool {
        let passwordData = password.data(using: .utf8)
        
        let query: [NSString : AnyObject] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: email as AnyObject,
            kSecAttrService: service as AnyObject,
            kSecValueData: passwordData as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    static func checkUser(with email: String, password: String) -> Bool {
        let query: [NSString : Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: email as AnyObject,
            kSecAttrService: service,
            kSecReturnData: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess,
           let data = result as? Data {
            let savedPassword = String(data: data, encoding: .utf8)
            
            return password == savedPassword
        } else {
            debugPrint("Error for getting password from keychain")
            return false
        }
    }
}
