//
//  UIViewController+Extension.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit

extension UIViewController {
    
    func showLoadingDialog() {
        self.view.endEditing(true)
        self.hideLoadingDialog()
        LoadingViewPresenter.shared.show()
    }
    
    func hideLoadingDialog() {
        LoadingViewPresenter.shared.hide()
    }
    
    func showActivityPopup(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func showContextualMenu(
        _ viewController: UIViewController,
        sourceView: UIView? = nil,
        delegate: ContextMenuDelegate? = nil
        ) {
        
        ContextMenu.shared.show(
            sourceViewController: self,
            viewController: viewController,
            sourceView: sourceView,
            delegate: delegate
        )
    }
}
