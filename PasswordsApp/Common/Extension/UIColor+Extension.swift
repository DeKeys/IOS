//
//  UIColor+Extension.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit

// MARK: - Dark Mode Support
extension UIColor {
    
    static var viewBackground: UIColor {
        if #available(iOS 13, *) {
            return UIColor(named: "viewBackground")!
        }
        return .white
    }
    
    static var navBarBackground: UIColor {
        if #available(iOS 13, *) {
            return UIColor(named: "navBarBackground")!
        }
        return .white
    }
    
    var isDarkColor: Bool {
        var red, green, blue, alpha: CGFloat
        (red, green, blue, alpha) = (0, 0, 0, 0)
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let lum = 0.2126 * red + 0.7152 * green + 0.0722 * blue
        return lum < 0.50 ? true : false
    }
}

// MARK: - Random Color Generation
extension UIColor {
    
    // TODO: - Make Gradient Color
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
