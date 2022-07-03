//
//  HomeProtocols.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import Foundation

// MARK: - Wireframe
protocol HomeRouterProtocol: AnyObject {
    func showProfile()
    func showNewPassword()
}

// MARK: - Presenter
protocol HomePresenterProtocol: AnyObject {
    var interactor: HomeInteractorInputProtocol? { get set }
    
    func getPasswords()
    func showProfile()
    func showNewPassword()
}

// MARK: - Interactor
protocol HomeInteractorOutputProtocol: AnyObject {
    func resultPasswords(passwords: Passwords)
    func showProfile()
    func showNewPassword()
    func errorService(message: String)
}

protocol HomeInteractorInputProtocol: AnyObject {
    var presenter: HomeInteractorOutputProtocol?  { get set }
    
    func getPasswords()
}

// MARK: - View
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol?  { get set }

    func setPasswords(passwords: Passwords)
    func errorService(message: String)
}
