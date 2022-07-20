//
//  HomeRouter.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit

class HomeRouter {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = HomeViewController(nibName: nil, bundle: nil)
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}

// MARK: - HomeRouterProtocol
extension HomeRouter: HomeRouterProtocol {
    
    // Show ProfileViewController
    func showProfile() {
//        let postVC = PostRouter.createModule()
//        viewController?.navigationController?.pushViewController(postVC, animated: true)
        print("Show ProfileViewController")
    }
    
    // Show NewPasswordViewController
    func showNewPassword() {
        let vc = NewPasswordRouter.createModule()
        viewController?.presentPanModal(vc)
//        let navigationController = UINavigationController(rootViewController: vc)
//        viewController?.present(navigationController, animated: true)
    }
    
    func showPassword(password: Password) {
        let vc = PasswordRouter.createModule() as? PasswordViewController
        if let vc = vc {
            vc.configureUI(with: password)
            viewController?.presentPanModal(vc)
        }
        
    }
}
