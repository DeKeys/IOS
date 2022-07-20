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
    
    func getPasswords() {
        do {
            let decoder = JSONDecoder()
            let cachedPasswords = try coreDataWorker.fetchPasswords()
            var pinnedPasswords = Passwords()
            var unpinnedPasswords = Passwords()
            for pwd in cachedPasswords {
                // Decode password and add it to the result array
                if let encodedPassword = KeychainWorker.load(key: pwd.ipfsHash!) {
                    var decodedPassword = try decoder.decode(Password.self, from: encodedPassword)
                    decodedPassword.pinned = pwd.pinned
                    if pwd.pinned {
                        pinnedPasswords.append(decodedPassword)
                    } else {
                        unpinnedPasswords.append(decodedPassword)
                    }
                } else {
                    self.presenter?.errorService(message: "Couldn't load password with hash \(pwd.ipfsHash!)")
                    // Clean up core data and keychain
                    let ipfsHash = pwd.ipfsHash!
                    try coreDataWorker.deletePassword(ipfsHash: ipfsHash)
                    let status = KeychainWorker.delete(key: ipfsHash)
                    if status != errSecSuccess {
                        if let hash = pwd.ipfsHash {
                            self.presenter?.errorService(message: "Couldn't delete password with hash \(hash)")
                        }
                    }
                }
            }
            pinnedPasswords.sort { $0.serviceName < $1.serviceName }
            unpinnedPasswords.sort { $0.serviceName < $1.serviceName }
            self.presenter?.resultPasswords(passwords: pinnedPasswords + unpinnedPasswords)
        } catch {
            self.presenter?.errorService(message: error.localizedDescription)
        }
    }
}
