//
//  PasswordViewController.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/7/22.
//

import UIKit
import SnapKit

class PasswordViewController: UIViewController {
    
    let serviceLabel = UILabel()
    let passwordLabel = UILabel()
    let copyButton = UIButton()
    let pinButton = UIButton()
    let deleteButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style labels
        // pin button
        var pinButtonConfiguration = UIButton.Configuration.plain()
//        pinButtonConfiguration.title = "Pin"
        pinButtonConfiguration.buttonSize = .small
        pinButtonConfiguration.imagePlacement = .leading
        pinButtonConfiguration.imagePadding = 8
        pinButtonConfiguration.image = UIImage(systemName: "star")
        pinButtonConfiguration.baseForegroundColor = .yellow
        
        pinButton.configuration = pinButtonConfiguration
        pinButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .medium)
        
        // labels
        serviceLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        passwordLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        passwordLabel.textAlignment = .center
        
        // delete button
        var deleteButtonConfiguration = UIButton.Configuration.plain()
//        deleteButtonConfiguration.title = "Delete"
        deleteButtonConfiguration.buttonSize = .small
        deleteButtonConfiguration.imagePlacement = .trailing
        deleteButtonConfiguration.imagePadding = 8
        deleteButtonConfiguration.image = UIImage(systemName: "xmark.bin")
        deleteButtonConfiguration.baseForegroundColor = .red
        
        deleteButton.configuration = deleteButtonConfiguration
        deleteButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .medium)
        
        // first level stack
        let firstStack = UIStackView(arrangedSubviews: [pinButton, serviceLabel, deleteButton])
        firstStack.axis = .horizontal
        firstStack.alignment = .center
        firstStack.distribution = .equalSpacing
        
        // copy button
        var copyButtonConfiguration = UIButton.Configuration.borderedProminent()
        copyButtonConfiguration.title = "Copy to Clipboard"
        copyButtonConfiguration.buttonSize = .medium
        copyButtonConfiguration.imagePlacement = .leading
        copyButtonConfiguration.imagePadding = 8
        
        copyButton.configuration = copyButtonConfiguration
        copyButton.titleLabel?.font =  UIFont.systemFont(ofSize: 12, weight: .medium)
        
        // second level stack
        let secondStack = UIStackView(arrangedSubviews: [firstStack, passwordLabel, copyButton])
        secondStack.axis = .vertical
        secondStack.spacing = 10
        secondStack.alignment = .center
        secondStack.distribution = .fillEqually
        
        // add to the view
        self.view.addSubview(secondStack)
        
        // set screen size
        preferredContentSize = CGSize(width: self.view.frame.width - 120, height: 150)
        
        secondStack.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.right.equalTo(0)
        }
        
        firstStack.snp.makeConstraints { make in
            make.left.right.equalTo(0)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.left.right.equalTo(0)
        }
        
        copyButton.snp.makeConstraints { make in
            make.width.equalTo(self.view.frame.width - 140)
        }
    }
    
    func configureUI(service: String, password: String) {
        serviceLabel.text = service
        passwordLabel.text = password
    }
}
