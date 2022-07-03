//
//  UIImageView+Extension.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    static let fadeAnimation = KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.2))
    
    func set(_ url: String, placeholder: UIImage? = nil, showActivityIndicator: Bool = false) {
        self.kf.setImage(with: URL(string: url), placeholder: placeholder, options: [UIImageView.fadeAnimation])
    }
}
