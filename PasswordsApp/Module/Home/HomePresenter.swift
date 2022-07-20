//
//  HomePresenter.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit

class HomePresenter: HomePresenterProtocol {

    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    private let router: HomeRouterProtocol

    init(interface: HomeViewProtocol, interactor: HomeInteractorInputProtocol?, router: HomeRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getPasswords() {
        interactor?.getPasswords()
    }
    
}

// MARK: - PostInteractorOutputProtocol
extension HomePresenter: HomeInteractorOutputProtocol {
    
    func showPassword(password: Password) {
        router.showPassword(password: password)
    }
    
    func resultPasswords(passwords: Passwords) {
        view?.setPasswords(passwords: passwords)
    }
    
    func showProfile() {
        router.showProfile()
    }
    
    func showNewPassword() {
        router.showNewPassword()
    }
    
    func errorService(message: String) {
        view?.errorService(message: message)
    }
}

