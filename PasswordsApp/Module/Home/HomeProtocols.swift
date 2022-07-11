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
    
    func addPassword(serviceName: String, login: String, password: String)
    func getPasswords()
    func pinPassword(password: Password)
    func deletePassword(password: Password)
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
    var presenter: HomeInteractorOutputProtocol? { get set }
    
    func addPassword(serviceName: String, login: String, password: String)
    func getPasswords()
    func pinPassword(password: Password)
    func deletePassword(password: Password)
}

// MARK: - View
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol?  { get set }

    func closePasswordVC()
    func setPasswords(passwords: Passwords)
    func errorService(message: String)
}
