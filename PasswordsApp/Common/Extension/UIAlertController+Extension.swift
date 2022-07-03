//
//  UIAlertController+Extension.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit

extension UIAlertController {
    
    convenience init(title: String, message: String? = nil, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
        if let color = tintColor {
            view.tintColor = color
        }
    }
}
