//
//  HomeInteractor.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    
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
