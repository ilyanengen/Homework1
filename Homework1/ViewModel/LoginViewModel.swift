//
//  LoginViewModel.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import Foundation

protocol LoginViewModelInterface {
    var username: String { get set }
    var password: String { get set }
    func signIn()
}

class LoginViewModel: LoginViewModelInterface {
    var username: String
    var password: String
    weak var view: LoginViewInterface?
    
    private let authService: AuthServiceInterface
    
    init(username: String = "", password: String = "", authService: AuthServiceInterface) {
        self.username = username
        self.password = password
        self.authService = authService
    }
    
    func signIn() {
        authService.signIn(username: username, password: password) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.view?.showErrorAlert(error: error)
            case .success(_):
                self?.view?.didSignInSuccessfully()
            }
        }
    }
}
