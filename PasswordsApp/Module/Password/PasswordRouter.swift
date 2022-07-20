//
//  PasswordRouter.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 20.07.2022.
//

import Foundation
import UIKit

class PasswordRouter {
    var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = PasswordViewController()
        let interactor = PasswordInteractor()
        let router = PasswordRouter()
        let presenter = PasswordPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

extension PasswordRouter: PasswordRouterProtocol {
    func passwordDeleted() {
        viewController?.dismiss(animated: true)
    }
}
