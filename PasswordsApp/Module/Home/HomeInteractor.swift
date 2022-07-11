//
//  HomeInteractor.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit

class HomeInteractor: HomeInteractorInputProtocol {
    weak var presenter: HomeInteractorOutputProtocol?
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
            if status == 0 {
                try coreDataWorker.addPassword(ipfsHash: ipfsHash)
            } else {
                self.presenter?.errorService(message: "Couldn't add password to the keychain. Error \(status)")
            }
        } catch {
            self.presenter?.errorService(message: error.localizedDescription)
        }
    }
    
    func getPasswords() {
        PasswordsWorker.dummyFetch { passwords, error in
            if error != nil {
                self.presenter?.errorService(message: error.debugDescription)
            }

            self.presenter?.resultPasswords(passwords: passwords)
        }
    }
    
    func pinPassword(password: Password) {
        print("Pin password")
    }
    
    func deletePassword(password: Password) {
        print("Delete password")
    }
}
