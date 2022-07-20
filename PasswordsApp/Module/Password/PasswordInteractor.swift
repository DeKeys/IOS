//
//  PasswordInteractor.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 20.07.2022.
//

import Foundation

class PasswordInteractor: PasswordInteractorInputProtocol {
    var presenter: PasswordInteractorOutputProtocol?
    private let coreDataWorker = CoreDataWorker()
    
    func pinPassword(password: Password) {
        coreDataWorker.setPinned(ipfsHash: password.ipfsHash, pinned: !password.pinned)
        NotificationCenter.default.post(name: NSNotification.Name("new password"), object: nil)
    }
    
    func deletePassword(password: Password) {
        // TODO: delete password from server
        
        do {
            try coreDataWorker.deletePassword(ipfsHash: password.ipfsHash)
            let status = KeychainWorker.delete(key: password.ipfsHash)
            if status != errSecSuccess {
                self.presenter?.errorService(message: "Couldn't delete password from keychain. Status code: \(status)")
            }
            NotificationCenter.default.post(name: NSNotification.Name("new password"), object: nil)
            presenter?.passwordDeleted()
        } catch {
            self.presenter?.errorService(message: error.localizedDescription)
        }
    }
}
