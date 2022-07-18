//
//  NewPasswordInteractor.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 13.07.2022.
//

import Foundation

class NewPasswordInteractor: NewPasswordInteractorInputProtocol {
    
    weak var presenter: NewPasswordInteractorOutputProtocol?
    var coreDataWorker = CoreDataWorker()
    
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
                presenter?.success()
            } else {
                self.presenter?.errorService(message: "Couldn't add password to the keychain. Error \(status)")
            }
        } catch {
            self.presenter?.errorService(message: error.localizedDescription)
        }
    }
    
    func generatePassword() {
        var password = ""
        let characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!$%&()*+-/:;<=>?@[]"
        for _ in 0..<16 {
            guard let randomChar = characters.randomElement() else {
                presenter?.errorService(message: "Couldn't create secure password")
                return
            }
            password += String(randomChar)
        }
        
        presenter?.generatedPassword(password: password)
    }
}
