//
//  EntryTextField.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 14.07.2022.
//

import Foundation
import UIKit


class EntryTextField : UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 10,
        bottom: 10,
        right: 10
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    
    func setupUI() {
        self.clipsToBounds = true
        self.font = .systemFont(ofSize: 14)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.4
        self.layer.borderColor = UIColor.white.cgColor
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
}
