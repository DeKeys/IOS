//
//  NewPasswordViewController.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 13.07.2022.
//

import Foundation
import UIKit
import PanModal

class NewPasswordViewController: UIViewController {
    
    var presenter: NewPasswordPresenterProtocol?
    var titleLabel = UILabel()
    
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
    
    var createPasswordButton = UIButton()
    
    var generatePasswordButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .background
        
        let labelFont = UIFont(font: FontFamily.Poppins.bold, size: 16)
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont(font: FontFamily.Poppins.bold, size: 24)
        titleLabel.text = "Create password"
        
        var createPasswordButtonConfig = UIButton.Configuration.plain()
        createPasswordButtonConfig.title = "Create"
        
        createPasswordButton.configuration = createPasswordButtonConfig
        createPasswordButton.addTarget(self, action: #selector(createButtonTapped), for: .touchDown)
        
        // Setup service name stack
        self.serviceLabel.text = "Service name"
        self.serviceLabel.font = labelFont
        self.serviceLabel.textColor = .white
        
        self.serviceTextField.placeholder = "Google"
        
        self.serviceStackView.axis = .vertical
        self.serviceStackView.spacing = 8
        
        self.serviceStackView.addArrangedSubview(self.serviceLabel)
        self.serviceStackView.addArrangedSubview(self.serviceTextField)
        
        // Setup login stack
        self.loginLabel.text = "Login"
        self.loginLabel.font = labelFont
        self.loginLabel.textColor = .white
//        self.loginLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
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
        self.passwordLabel.text = "Password"
        self.passwordLabel.font = labelFont
        self.passwordLabel.textColor = .white
        
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
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(createPasswordButton)
        self.view.addSubview(serviceStackView)
        self.view.addSubview(loginStackView)
        self.view.addSubview(passwordStackView)
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
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(12)
        }
        
        createPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.right.equalTo(view.snp.right).offset(-12)
            
        }
        
        serviceStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
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

// MARK: - PanModalPresentable
extension NewPasswordViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
}

// MARK: - Handle Keyboard Apperance
extension NewPasswordViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
