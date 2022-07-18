//
//  PasswordTextField.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 14.07.2022.
//

import Foundation
import UIKit


class PasswordTextField : EntryTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textContentType = .password
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
}
