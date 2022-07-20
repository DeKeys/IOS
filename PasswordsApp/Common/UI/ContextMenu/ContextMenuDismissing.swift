//
//  ContextMenuDismissing.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/10/22.
//

import UIKit

class ContextMenuDismissing: NSObject, UIViewControllerAnimatedTransitioning {

    private let menu: ContextMenu.Menu

    init(menu: ContextMenu.Menu) {
        self.menu = menu
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }

        let delegate = menu.delegate
        let viewController = menu.viewController.viewController
        let animated = transitionContext.isAnimated
       
        delegate?.contextMenuWillDismiss(viewController: viewController, animated: animated)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromViewController.view.alpha = 0
        }) { _ in
            delegate?.contextMenuDidDismiss(viewController: viewController, animated: animated)
            transitionContext.completeTransition(true)
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
}
