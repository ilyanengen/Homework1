//
//  LoginViewModel.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import Foundation

protocol LoginViewModelInterface: LoginViewModel {
    var authService: AuthServiceInterface { get set }
}

class LoginViewModel: LoginViewModelInterface {
    var authService: AuthServiceInterface
    
    init(authService: AuthServiceInterface) {
        self.authService = authService
    }
}
