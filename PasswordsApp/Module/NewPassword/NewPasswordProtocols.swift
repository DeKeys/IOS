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
}

// MARK: - Interactor
protocol NewPasswordInteractorOutputProtocol: AnyObject {
    func success()
    func errorService(message: String)
}

protocol NewPasswordInteractorInputProtocol: AnyObject {
    var presenter: NewPasswordInteractorOutputProtocol? { get set }
    
    func addPassword(serviceName: String, login: String, password: String)
}

// MARK: - View
protocol NewPasswordViewProtocol: AnyObject {
    var presenter: NewPasswordPresenterProtocol? { get set}
    
    func errorService(message: String)
}
