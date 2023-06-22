//
//  AppCoordinator.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import UIKit

protocol AppCoordinatorInterface {
    var isLoggedIn: Bool { get set }
    func start()
    func showListScreen()
    func showLoginScreen()
}

protocol AppCoordinatorDelegate: AnyObject {
    func didSignInSuccessfully()
}

class AppCoordinator: AppCoordinatorInterface {
    var isLoggedIn: Bool = false
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if isLoggedIn {
            showListScreen()
        } else {
            showLoginScreen()
        }
    }
    
    func showListScreen() {
        let networkManager = NetworkManager()
        let urlString = "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new"
        let itemService = ItemService(networkManager: networkManager, fetchStringsUrl: urlString)
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
