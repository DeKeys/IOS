//
//  ContextMenu.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/10/22.
//

import UIKit

class ContextMenu: NSObject {

    static let shared = ContextMenu()
    var menu: Menu?
    
    func show(
        sourceViewController: UIViewController,
        viewController: UIViewController,
        sourceView: UIView? = nil,
        delegate: ContextMenuDelegate? = nil
    ) {
        if let previous = self.menu {
            previous.viewController.dismiss(animated: false)
        }

        let haptics = UIImpactFeedbackGenerator(style: .medium)
        haptics.impactOccurred()

        let menu = Menu(
            viewController: viewController,
            sourceView: sourceView,
            delegate: delegate
        )
        self.menu = menu

        menu.viewController.transitioningDelegate = self
        menu.viewController.modalPresentationStyle = .custom
        menu.viewController.modalPresentationCapturesStatusBarAppearance = true
        sourceViewController.present(menu.viewController, animated: true)
    }
}

// MARK: - Menu Class
extension ContextMenu {
    
    class Menu {
        let viewController: ClippedContainerViewController

        weak var sourceView: UIView?
        weak var delegate: ContextMenuDelegate?

        init(
            viewController: UIViewController,
            sourceView: UIView?,
            delegate: ContextMenuDelegate?
        ) {
            self.viewController = ClippedContainerViewController( viewController: viewController)
            self.sourceView = sourceView
            self.delegate = delegate
        }
    }
}

// MARK: - ContextMenuPresentationControllerDelegate
extension ContextMenu: ContextMenuPresentationControllerDelegate {

    func willDismiss(presentationController: ContextMenuPresentationController) {
        guard menu?.viewController === presentationController.presentedViewController else { return }
        menu = nil
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension ContextMenu: UIViewControllerTransitioningDelegate {

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let menu = self.menu else { return nil }
        return ContextMenuDismissing(menu: menu)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ContextMenuPresenting()
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let menu = self.menu else { return nil }
        let controller = ContextMenuPresentationController(presentedViewController: presented, presenting: presenting, menu: menu)
        controller.contextDelegate = self
        return controller
    }
}
