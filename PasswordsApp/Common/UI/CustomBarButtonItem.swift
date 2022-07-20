//
//  CustomBarButtonItem.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 20.07.2022.
//

import Foundation
import UIKit

class CustomBarButtonItem: UIBarButtonItem {
    init(image: UIImage) {
        super.init()
        
        let button = UIButton()
        var buttonConfig = UIButton.Configuration.plain()
        
        buttonConfig.image = image
        
        button.configuration = buttonConfig
        button.layer.cornerRadius = 10
        button.backgroundColor = .cellBackground
        button.tintColor = .white
        
        self.customView = button
        
        button.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
