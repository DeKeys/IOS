//
//  NewPasswordPresenter.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 13.07.2022.
//

import Foundation

class NewPasswordPresenter: NewPasswordPresenterProtocol {
    var interactor: NewPasswordInteractorInputProtocol?
    var router: NewPasswordRouterProtocol?
    
    func addPassword(serviceName: String, login: String, password: String) {
        interactor?.addPassword(serviceName: serviceName, login: login, password: password)
    }
    
}

extension NewPasswordPresenter: NewPasswordInteractorOutputProtocol {
    func errorService(message: String) {
        
    }
    
    func success() {
        
    }
}
