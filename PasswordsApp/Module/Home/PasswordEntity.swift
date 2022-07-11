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
    let ipfsHash: String
    let createdAt: Int // as utc timestamp
    var pinIndex: Int = -1

    enum CodingKeys: String, CodingKey {
        case serviceName = "service"
        case login
        case password
        case ipfsHash
        case createdAt
    }
}
