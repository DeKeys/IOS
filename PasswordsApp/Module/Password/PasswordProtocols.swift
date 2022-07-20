//
//  PasswordProtocols.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 20.07.2022.
//

import Foundation

// MARK: - Wireframe
protocol PasswordRouterProtocol: AnyObject {
    func passwordDeleted()
}

// MARK: - Interactor
protocol PasswordInteractorOutputProtocol: AnyObject {
    func passwordDeleted()
    func errorService(message: String)
}

protocol PasswordInteractorInputProtocol: AnyObject {
    var presenter: PasswordInteractorOutputProtocol? { get set }
    
    func pinPassword(password: Password)
    func deletePassword(password: Password)
}

// MARK: - Presenter
protocol PasswordPresenterProtocol: AnyObject {
    var interactor: PasswordInteractorInputProtocol? { get set }
    
    func pinPassword(password: Password)
    func deletePassword(password: Password)
    func errorService(message: String)
}

// MARK: - View
protocol PasswordViewProtocol: AnyObject {
    var presenter: PasswordPresenterProtocol? { get set }
    
    func errorService(message: String)
}
