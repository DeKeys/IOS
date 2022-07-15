//
//  NewPasswordProtocols.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 13.07.2022.
//

import Foundation

// MARK: - Wireframe
protocol NewPasswordRouterProtocol: AnyObject {
    func updateCollectionView()
}

// MARK: - Presenter
protocol NewPasswordPresenterProtocol: AnyObject {
    var interactor: NewPasswordInteractorInputProtocol? { get set }
    
    func addPassword(serviceName: String, login: String, password: String)
    func generatePassword()
}

// MARK: - Interactor
protocol NewPasswordInteractorOutputProtocol: AnyObject {
    func success()
    func generatedPassword(password: String)
    func errorService(message: String)
}

protocol NewPasswordInteractorInputProtocol: AnyObject {
    var presenter: NewPasswordInteractorOutputProtocol? { get set }
    
    func addPassword(serviceName: String, login: String, password: String)
    func generatePassword()
}

// MARK: - View
protocol NewPasswordViewProtocol: AnyObject {
    var presenter: NewPasswordPresenterProtocol? { get set}
    
    func close()
    func errorService(message: String)
    func setPassword(password: String)
}
