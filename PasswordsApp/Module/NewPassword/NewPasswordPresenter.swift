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
        if serviceName.trimmingCharacters(in: .whitespaces).isEmpty {
            view?.errorService(message: "Service name is empty")
            return
        }
        if login.trimmingCharacters(in: .whitespaces).isEmpty {
            view?.errorService(message: "Login is empty")
            return
        }
        if password.trimmingCharacters(in: .whitespaces).isEmpty {
            view?.errorService(message: "Password is empty")
            return
        }
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
        if let vc = view {
            router?.successGoBack(from: vc)
        }
    }
    
    func generatedPassword(password: String) {
        view?.setPassword(password: password)
    }
}
