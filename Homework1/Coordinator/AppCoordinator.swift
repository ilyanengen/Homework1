//
//  AppCoordinator.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import UIKit

protocol AppCoordinatorInterface {
    func start()
    func showListScreen()
    func showLoginScreen()
}

protocol AppCoordinatorDelegate: AnyObject {
    func didSignInSuccessfully()
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
    
    func showListScreen() {
        let itemService = ItemService()
        let itemListViewModel = ItemListViewModel(itemService: itemService)
        let itemListVC = ItemListViewController()
        itemListVC.viewModel = itemListViewModel
        itemListViewModel.view = itemListVC
        itemListVC.delegate = self
        self.navigationController.viewControllers = [itemListVC]
    }
    
    func showLoginScreen() {
        let authService = AuthService()
        let loginViewModel = LoginViewModel(username: "user", password: "123qwe", authService: authService)
        let loginVC = LoginViewController()
        loginVC.viewModel = loginViewModel
        loginViewModel.view = loginVC
        loginVC.delegate = self
        self.navigationController.viewControllers = [loginVC]
    }
}

extension AppCoordinator: AppCoordinatorDelegate {
    func didSignInSuccessfully() {
        showListScreen()
    }
}
