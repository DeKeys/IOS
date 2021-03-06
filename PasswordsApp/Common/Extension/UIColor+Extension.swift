//
//  UIColor+Extension.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/3/22.
//

import UIKit

// MARK: - Custom Background
extension UIColor {
    
    static var background: UIColor {
        return UIColor(patternImage: UIImage.background)
    }
    
    static var cellBackground: UIColor {
        return Asset.cellBackground.color.withAlphaComponent(0.14)
    }
}

extension CGColor {
    
    static var cellBackground: CGColor {
        return Asset.cellBackground.color.withAlphaComponent(0.14).cgColor
    }
    
    static var pinBorder: CGColor {
        return Asset.pinBorder.color.withAlphaComponent(0.8).cgColor
    }
}

extension UIImage {
    
    static var background: UIImage {
        return Asset.background.image
    }
}

// MARK: - Random Color Generation
extension UIColor {
    
    static func generateColorFor(text: String) -> UIColor {
        
        var hash = 0
        let colorConstant = 131
        let maxSafeValue = Int.max / colorConstant
        
        for char in text.unicodeScalars {
            if hash > maxSafeValue {
                hash /= colorConstant
            }
            hash = Int(char.value) + ((hash << 5) - hash)
        }
        
        let finalHash = abs(hash) % (256 * 256 * 256)
        let color = UIColor(hue: CGFloat(finalHash) / 255.0, saturation: 0.60, brightness: 0.6, alpha: 1.0)
        
        return color
    }
}
