//
//  PasswordPresenter.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 20.07.2022.
//

import Foundation

class PasswordPresenter: PasswordPresenterProtocol {
    
    weak private var view: PasswordViewProtocol?
    var interactor: PasswordInteractorInputProtocol?
    private let router: PasswordRouterProtocol?
    
    init(interface: PasswordViewProtocol, interactor: PasswordInteractorInputProtocol, router: PasswordRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func pinPassword(password: Password) {
        interactor?.pinPassword(password: password)
    }
    
    func deletePassword(password: Password) {
        interactor?.deletePassword(password: password)
    }
        
    func errorService(message: String) {
        view?.errorService(message: message)
    }
}

extension PasswordPresenter: PasswordInteractorOutputProtocol {
    func passwordDeleted() {
        router?.passwordDeleted()
    }
}
