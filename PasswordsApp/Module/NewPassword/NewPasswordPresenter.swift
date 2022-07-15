//
//  NewPasswordPresenter.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 13.07.2022.
//

import Foundation

class NewPasswordPresenter: NewPasswordPresenterProtocol {
    weak private var view: NewPasswordViewProtocol?
    var interactor: NewPasswordInteractorInputProtocol?
    private let router: NewPasswordRouterProtocol?
    
    init(interface: NewPasswordViewProtocol, interactor: NewPasswordInteractorInputProtocol?, router: NewPasswordRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func addPassword(serviceName: String, login: String, password: String) {
        interactor?.addPassword(serviceName: serviceName, login: login, password: password)
    }
    
    func generatePassword() {
        interactor?.generatePassword()
    }
    
}

extension NewPasswordPresenter: NewPasswordInteractorOutputProtocol {
    func errorService(message: String) {
        view?.errorService(message: message)
    }
    
    func success() {
        view?.close()
    }
    
    func generatedPassword(password: String) {
        view?.setPassword(password: password)
    }
}
