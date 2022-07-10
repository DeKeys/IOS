//
//  PasswordViewController.swift
//  PasswordsApp
//
//  Created by Roman Rakhlin on 7/7/22.
//

import UIKit
import SnapKit

class PasswordViewController: UIViewController {
    
    var presenter: HomePresenterProtocol?
    var password: Password!
    
    let serviceLabel = UILabel()
    let pinButton = UIButton()
    let deleteButton = UIButton()
    let loginButton = UIButton()
    let passwordButton = UIButton()
    
    let firstLevel = UIStackView()
    let secondLevel = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = CGSize(width: self.view.frame.width - 120, height: 140)
    }
    
    func configureUI(with password: Password) {
        self.password = password
        
        setupHeader(service: password.serviceName)
        setupCopyButtons(login: password.login, password: password.password)
        setupConstraints()
    }
    
    private func setupHeader(service: String) {
        // pin button
        var pinButtonConfiguration = UIButton.Configuration.plain()
        pinButtonConfiguration.buttonSize = .small
        pinButtonConfiguration.imagePlacement = .leading
        pinButtonConfiguration.imagePadding = 8
        pinButtonConfiguration.image = UIImage(systemName: "star")
        pinButtonConfiguration.baseForegroundColor = .orange
        
        pinButton.configuration = pinButtonConfiguration
        pinButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .medium)
        pinButton.addTarget(self, action: #selector(pinPassword), for: .touchUpInside)
        
        // service label
        serviceLabel.text = service
        serviceLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        // delete button
        var deleteButtonConfiguration = UIButton.Configuration.plain()
        deleteButtonConfiguration.buttonSize = .small
        deleteButtonConfiguration.imagePlacement = .trailing
        deleteButtonConfiguration.imagePadding = 8
        deleteButtonConfiguration.image = UIImage(systemName: "xmark.bin")
        deleteButtonConfiguration.baseForegroundColor = .red
        
        deleteButton.configuration = deleteButtonConfiguration
        deleteButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .medium)
        deleteButton.addTarget(self, action: #selector(deletePassword), for: .touchUpInside)
        
        // first level stack
        firstLevel.addArrangedSubview(pinButton)
        firstLevel.addArrangedSubview(serviceLabel)
        firstLevel.addArrangedSubview(deleteButton)
        firstLevel.axis = .horizontal
        firstLevel.alignment = .center
        firstLevel.distribution = .equalSpacing
        
        // add to the view
        self.view.addSubview(firstLevel)
    }
    
    @objc func pinPassword(sender: UIButton) {
        presenter?.pinPassword(password: password)
    }
    
    @objc func deletePassword(sender: UIButton) {
        presenter?.deletePassword(password: password)
    }
    
    private func setupCopyButtons(login: String, password: String) {
        // login button
        var loginButtonConfiguration = UIButton.Configuration.gray()
        loginButtonConfiguration.title = login
        loginButtonConfiguration.baseForegroundColor = .darkGray
        loginButtonConfiguration.image = UIImage(systemName: "doc.on.doc")
        loginButtonConfiguration.buttonSize = .medium
        loginButtonConfiguration.imagePlacement = .trailing
    
        loginButton.configuration = loginButtonConfiguration
        loginButton.titleLabel?.font =  UIFont.systemFont(ofSize: 12, weight: .medium)
        loginButton.addTarget(self, action: #selector(copyTextToClipboard), for: .touchUpInside)
        
        // password button
        var passwordButtonConfiguration = UIButton.Configuration.gray()
        passwordButtonConfiguration.title = password
        passwordButtonConfiguration.baseForegroundColor = .darkGray
        passwordButtonConfiguration.image = UIImage(systemName: "doc.on.doc")
        passwordButtonConfiguration.buttonSize = .medium
        passwordButtonConfiguration.imagePlacement = .trailing
        
        passwordButton.configuration = passwordButtonConfiguration
        passwordButton.titleLabel?.font =  UIFont.systemFont(ofSize: 12, weight: .medium)
        passwordButton.addTarget(self, action: #selector(copyTextToClipboard), for: .touchUpInside)
        
        // second level stack
        secondLevel.addArrangedSubview(loginButton)
        secondLevel.addArrangedSubview(passwordButton)
        secondLevel.axis = .vertical
        secondLevel.spacing = 10
        secondLevel.alignment = .center
        secondLevel.distribution = .fillEqually
        
        // add to the view
        self.view.addSubview(secondLevel)
    }
    
    @objc func copyTextToClipboard(sender: UIButton) {
        UIPasteboard.general.string = sender.titleLabel?.text
    }
    
    private func setupConstraints() {
        firstLevel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.right.equalTo(0)
        }
        
        secondLevel.snp.makeConstraints { make in
            make.top.equalTo(firstLevel.snp.bottom).offset(10)
            make.left.right.equalTo(0)
        }
        
        // login button
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(self.view.frame.width - 140)
        }
        
        loginButton.titleLabel!.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalTo(loginButton)
        }
        
        loginButton.imageView!.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.width.equalTo(22)
            make.right.equalTo(-10)
            make.centerY.equalTo(loginButton)
        }
        
        // password button
        passwordButton.snp.makeConstraints { make in
            make.width.equalTo(self.view.frame.width - 140)
        }
        
        passwordButton.titleLabel!.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalTo(passwordButton)
        }
        
        passwordButton.imageView!.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.width.equalTo(22)
            make.right.equalTo(-10)
            make.centerY.equalTo(passwordButton)
        }
    }
}
