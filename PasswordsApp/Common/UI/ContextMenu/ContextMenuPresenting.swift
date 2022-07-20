//
//  ContextMenuPresenting.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/10/22.
//

import UIKit

class ContextMenuPresenting: NSObject, UIViewControllerAnimatedTransitioning {

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }

        let containerView = transitionContext.containerView

        containerView.addSubview(toViewController.view)

        toViewController.view.alpha = 0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.alpha = 1
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
}
