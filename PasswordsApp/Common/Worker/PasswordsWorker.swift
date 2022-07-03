//
//  PasswordsWorker.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import Foundation

struct PasswordsWorker {
    
    // TODO: - Implement Function
    static func fetchPasswords(completion: @escaping (Passwords, Error?) -> Void) {
        
    }
    
    static func dummyFetch(completion: @escaping (Passwords, Error?) -> Void) {
        let dummyPasswords: Passwords = [
            Password(serviceName: "Google", login: "hui228", password: "12345678"),
            Password(serviceName: "Facebook", login: "hui22", password: "12345678"),
            Password(serviceName: "Twitter", login: "hui2", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678")
        ]
        
        completion(dummyPasswords, nil)
    }
}
