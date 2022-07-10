//
//  ClippedContainerViewController.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/10/22.
//

import UIKit

class ClippedContainerViewController: UIViewController {

    let viewController: UIViewController
    private let containedViewController: UINavigationController

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewController.preferredStatusBarStyle
    }

    init(viewController: UIViewController) {
        self.viewController = viewController
        self.containedViewController = UINavigationController(rootViewController: viewController)
        super.init(nibName: nil, bundle: nil)
        self.containedViewController.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 12
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowColor = UIColor.black.cgColor
        view.backgroundColor = .white

        if UIAccessibility.isReduceMotionEnabled == false {
            let amount = 12
            let tiltX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            tiltX.minimumRelativeValue = -amount
            tiltX.maximumRelativeValue = amount

            let tiltY = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
            tiltY.minimumRelativeValue = -amount
            tiltY.maximumRelativeValue = amount

            let group = UIMotionEffectGroup()
            group.motionEffects = [tiltX, tiltY]
            view.addMotionEffect(group)
        }

        containedViewController.view.layer.cornerRadius = view.layer.cornerRadius
        containedViewController.view.clipsToBounds = true
        containedViewController.setNavigationBarHidden(true, animated: false)

        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }

        UIBezierPath(rect: CGRect(origin: .zero, size: size)).fill()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        let navigationBar = containedViewController.navigationBar
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(image, for: .any, barMetrics: .default)
        navigationBar.shadowImage = image

        addChild(containedViewController)
        view.addSubview(containedViewController.view)
        containedViewController.didMove(toParent: self)

        preferredContentSize = containedViewController.preferredContentSize
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        containedViewController.view.frame = view.bounds
    }

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        preferredContentSize = container.preferredContentSize
    }

}

extension ClippedContainerViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.view.backgroundColor = .white
    }
}
