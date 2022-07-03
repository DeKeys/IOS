//
//  PasswordEntity.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import Foundation

typealias Passwords = [Password]

struct Password: Codable {
    
    let serviceName: String
    let login: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case serviceName = "service"
        case login
        case password
    }
}
