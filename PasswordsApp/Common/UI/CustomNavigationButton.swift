//
//  CustomNavigationButton.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 20.07.2022.
//

import Foundation
import UIKit

class CustomNavigationButton: UIBarButtonItem {
    init(image: UIImage) {
        super.init()
        
        let button = UIButton()
        var buttonConfig = UIButton.Configuration.plain()
        
        buttonConfig.image = image
        
        button.configuration = buttonConfig
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.tintColor = .white
        
        button.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        self.customView = button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
