//
//  NewPasswordViewController.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 13.07.2022.
//

import Foundation
import UIKit

class NewPasswordViewController: UIViewController {
    
    var presenter: NewPasswordPresenterProtocol?
    
    var serviceStackView = UIStackView()
    var loginStackView = UIStackView()
    var passwordStackView = UIStackView()
    var passwordTextFieldStackView = UIStackView()
    
    var serviceLabel = UILabel()
    var loginLabel = UILabel()
    var passwordLabel = UILabel()
    
    var serviceTextField = EntryTextField()
    var loginTextField = EntryTextField()
    var passwordTextField = PasswordTextField()
    
    var generatePasswordButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigation()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .viewBackground
        
        // Setup service name stack
        self.serviceLabel.text = "Service name:"
        self.serviceLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        
        self.serviceTextField.placeholder = "Google"
        
        self.serviceStackView.axis = .vertical
        self.serviceStackView.spacing = 8
        
        self.serviceStackView.addArrangedSubview(self.serviceLabel)
        self.serviceStackView.addArrangedSubview(self.serviceTextField)
        
        // Setup login stack
        self.loginLabel.text = "Login:"
        self.loginLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        self.loginTextField.placeholder = "test"
        self.loginTextField.textContentType = .username
        
        self.loginStackView.axis = .vertical
        self.loginStackView.spacing = 8
        
        self.loginStackView.addArrangedSubview(self.loginLabel)
        self.loginStackView.addArrangedSubview(self.loginTextField)
        
        var generateButtonConfig = UIButton.Configuration.plain()
        generateButtonConfig.image = UIImage(systemName: "lock.shield")
        
        // Setup generate button
        self.generatePasswordButton.clipsToBounds = true
        self.generatePasswordButton.configuration = generateButtonConfig
        self.generatePasswordButton.backgroundColor = .black
        self.generatePasswordButton.tintColor = .white
        self.generatePasswordButton.layer.cornerRadius = 10
        self.generatePasswordButton.addTarget(self, action: #selector(generateButtonTapped), for: .touchDown)
        
        // Setup password stack
        self.passwordLabel.text = "Password:"
        self.passwordLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        self.passwordTextField.placeholder = "qwerty"
        
        self.passwordStackView.axis = .vertical
        self.passwordStackView.spacing = 8
        
        self.passwordTextFieldStackView.axis = .horizontal
        self.passwordTextFieldStackView.alignment = .trailing
        self.passwordTextFieldStackView.distribution = .fillProportionally
        self.passwordTextFieldStackView.addArrangedSubview(self.passwordTextField)
        self.passwordTextFieldStackView.addArrangedSubview(self.generatePasswordButton)
        
        self.passwordStackView.addArrangedSubview(self.passwordLabel)
        self.passwordStackView.addArrangedSubview(self.passwordTextFieldStackView)
        
        self.view.addSubview(serviceStackView)
        self.view.addSubview(loginStackView)
        self.view.addSubview(passwordStackView)
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Create password"
        
        let createButton = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createButtonTapped))
        createButton.tintColor = .textColor
        
        self.navigationItem.rightBarButtonItem = createButton
    }
    
    // MARK: - Selectors
    @objc func createButtonTapped(_ sender: UIBarButtonItem?) {
        presenter?.addPassword(serviceName: self.serviceTextField.text ?? "", login: self.loginTextField.text ?? "", password: self.passwordTextField.text ?? "")
    }
    
    @objc func generateButtonTapped(_ sender: UIButton?) {
        presenter?.generatePassword()
    }

    // MARK: - Constraints
    private func setupConstraints() {
        serviceStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(12)
            make.right.equalTo(-12)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(self.serviceStackView.snp.bottom).offset(20)
            make.left.equalTo(12)
            make.right.equalTo(-12)
        }
        
        passwordStackView.snp.makeConstraints { make in
            make.top.equalTo(self.loginStackView.snp.bottom).offset(20)
            make.left.equalTo(12)
            make.right.equalTo(-12)
        }
        
        generatePasswordButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(self.passwordTextField.snp.height)
            make.left.equalTo(self.passwordTextField.snp.right).offset(8)
        }
    }
    
    func isBeingDismissed() {
        print(1)
    }
}

// MARK: - Protocol stubs
extension NewPasswordViewController: NewPasswordViewProtocol {
    func setPassword(password: String) {
        self.passwordTextField.text = password
    }
    
    func close() {
        self.dismiss(animated: true)
    }
    
    func errorService(message: String) {
        self.showActivityPopup(title: "Error occurred", message: message)
    }
}
