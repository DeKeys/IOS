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
            Password(serviceName: "Google", login: "hui228@gmail.com", password: "12345678"),
            Password(serviceName: "Facebook", login: "hui228@gmail.com", password: "12345678"),
            Password(serviceName: "Twitter", login: "hui228@gmail.com", password: "12345678"),
            Password(serviceName: "Arega", login: "hui228@gmail.com", password: "12345678"),
            Password(serviceName: "Brega", login: "hui228@gmail.com", password: "12345678"),
            Password(serviceName: "Crega", login: "hui228@gmail.com", password: "12345678"),
            Password(serviceName: "Drega", login: "hui228@gmail.com", password: "12345678"),
            Password(serviceName: "Erega", login: "hui228@gmail.com", password: "12345678"),
            Password(serviceName: "Frega", login: "hui228@gmail.com", password: "12345678"),
            Password(serviceName: "Grega", login: "hui", password: "12345678"),
            Password(serviceName: "Hrega", login: "hui", password: "12345678"),
            Password(serviceName: "Irega", login: "hui", password: "12345678"),
            Password(serviceName: "Jrega", login: "hui", password: "12345678"),
            Password(serviceName: "Krega", login: "hui", password: "12345678"),
            Password(serviceName: "Lrega", login: "hui", password: "12345678"),
            Password(serviceName: "Mrega", login: "hui", password: "12345678"),
            Password(serviceName: "Nrega", login: "hui", password: "12345678"),
            Password(serviceName: "Orega", login: "hui", password: "12345678"),
            Password(serviceName: "Prega", login: "hui", password: "12345678"),
            Password(serviceName: "Qrega", login: "hui", password: "12345678"),
            Password(serviceName: "Srega", login: "hui", password: "12345678"),
            Password(serviceName: "Trega", login: "hui", password: "12345678")
        ]
        
        completion(dummyPasswords, nil)
    }
}
