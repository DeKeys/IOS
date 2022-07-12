//
//  HomeInteractor.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    
    let coreDataWorker = CoreDataWorker()
    
    func addPassword(serviceName: String, login: String, password: String) {
        // TODO: add password to the server
        
        // TODO: change ipfs hash to the returned one from the server
        let ipfsHash = String(serviceName.hashValue)
        let password = Password(serviceName: serviceName, login: login, password: password, ipfsHash: ipfsHash, createdAt: Int(Date().timeIntervalSince1970))
        let encoder = JSONEncoder()
        do {
            let encodedPassword = try encoder.encode(password)
            let status = KeychainWorker.save(key: ipfsHash, data: encodedPassword)
            if status == errSecSuccess {
                try coreDataWorker.addPassword(ipfsHash: ipfsHash)
            } else {
                self.presenter?.errorService(message: "Couldn't add password to the keychain. Error \(status)")
            }
        } catch {
            self.presenter?.errorService(message: error.localizedDescription)
        }
    }
    
    func getPasswords() {
        do {
            let decoder = JSONDecoder()
            let cachedPasswords = try coreDataWorker.fetchPasswords()
            var passwords = Passwords()
            for pwd in cachedPasswords {
                // Decode password and add it to the result array
                if let encodedPassword = KeychainWorker.load(key: pwd.ipfsHash!) {
                    var decodedPassword = try decoder.decode(Password.self, from: encodedPassword)
                    decodedPassword.pinned = pwd.pinned
                    passwords.append(decodedPassword)
                } else {
                    self.presenter?.errorService(message: "Couldn't load password with hash \(pwd.ipfsHash!)")
                    // Clean up core data and keychain
                    let ipfsHash = pwd.ipfsHash!
                    try coreDataWorker.deletePassword(ipfsHash: ipfsHash)
                    let status = KeychainWorker.delete(key: ipfsHash)
                    if status != errSecSuccess {
                        self.presenter?.errorService(message: "Couldn't delete password with hash \(pwd.ipfsHash!)")
                    }
                }
            }
            self.presenter?.resultPasswords(passwords: passwords)
        } catch {
            self.presenter?.errorService(message: error.localizedDescription)
        }
    }
    
    func pinPassword(password: Password) {
        coreDataWorker.setPinned(ipfsHash: password.ipfsHash, pinned: !password.pinned)
    }
    
    func deletePassword(password: Password) {
        // TODO: delete password from server
        
        do {
            try coreDataWorker.deletePassword(ipfsHash: password.ipfsHash)
            let status = KeychainWorker.delete(key: password.ipfsHash)
            if status != errSecSuccess {
                self.presenter?.errorService(message: "Couldn't delete password from keychain. Status code: \(status)")
            }
        } catch {
            self.presenter?.errorService(message: error.localizedDescription)
        }
    }
}
