//
//  ContextMenuDelegate.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/11/22.
//

import UIKit

protocol ContextMenuDelegate: AnyObject {
    func contextMenuWillDismiss(viewController: UIViewController, animated: Bool)
    func contextMenuDidDismiss(viewController: UIViewController, animated: Bool)
}

protocol ContextMenuPresentationControllerDelegate: AnyObject {
    func willDismiss(presentationController: ContextMenuPresentationController)
}
