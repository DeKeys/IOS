//
//  NewPasswordRouter.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 13.07.2022.
//

import Foundation
import UIKit

class NewPasswordRouter: NewPasswordRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> NewPasswordViewController {
        let view = NewPasswordViewController(nibName: nil, bundle: nil)
        let interactor = NewPasswordInteractor()
        let router = NewPasswordRouter()
        let presenter = NewPasswordPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func successGoBack(from view: NewPasswordViewProtocol) {
        NotificationCenter.default.post(name: Notification.Name("new password"), object: nil, userInfo: nil)
        view.close()
    }
}
