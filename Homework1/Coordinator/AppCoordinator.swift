//
//  AppCoordinator.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import UIKit

protocol AppCoordinatorInterface {
    func start()
    func showMainScreen()
    func showLoginScreen()
}

class AppCoordinator: AppCoordinatorInterface {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // TODO: check whether user is already signed in -> call showMainScreen / showLoginScreen
        showLoginScreen()
    }
    
    func showMainScreen() {
        // TODO
    }
    
    func showLoginScreen() {
        let authService = AuthService()
        let loginViewModel = LoginViewModel(authService: authService)
        var loginVC = LoginViewController()
        loginVC.viewModel = loginViewModel
        self.navigationController.viewControllers = [loginVC]
    }
}
