//
//  LoginViewController.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import UIKit

protocol LoginViewControllerInterface: AnyObject {
    var viewModel: LoginViewModelInterface? { get set }
    func showErrorAlert(error: Error)
    func didSignInSuccessfully()
}

class LoginViewController: UIViewController, LoginViewControllerInterface {
    var viewModel: LoginViewModelInterface?
    weak var delegate: AppCoordinatorDelegate?
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Sign in"
        config.buttonSize = .large
        config.image = UIImage(systemName: "key",
          withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.imagePlacement = .trailing
        config.imagePadding = 8.0
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func showErrorAlert(error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        errorAlert.addAction(.init(title: "OK", style: .default))
        present(errorAlert, animated: true)
    }
    
    func didSignInSuccessfully() {
        delegate?.didSignInSuccessfully()
    }
    
    private func setupViews() {
        view.backgroundColor = .lightGray
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        viewModel?.signIn()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            viewModel?.username = textField.text ?? ""
        } else if textField == passwordTextField {
            viewModel?.password = textField.text ?? ""
        }
    }
}
