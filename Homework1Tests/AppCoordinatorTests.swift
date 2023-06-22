//
//  AppCoordinatorTests.swift
//  Homework1Tests
//
//  Created by Ilia Biltuev on 22.06.2023.
//

import XCTest
@testable import Homework1

final class AppCoordinatorTests: XCTestCase {
    func testStartForLoggedIn() {
        let navController = UINavigationController()
        let sut = AppCoordinator(navigationController: navController)
        sut.isLoggedIn = false
        sut.start()
        let isLoginVC = navController.topViewController is LoginViewController
        XCTAssertTrue(isLoginVC)
    }
    
    func testStartForNoLoggedIn() {
        let navController = UINavigationController()
        let sut = AppCoordinator(navigationController: navController)
        sut.isLoggedIn = true
        sut.start()
        let isItemListVC = navController.topViewController is ItemListViewController
        XCTAssertTrue(isItemListVC)
    }
    
    func testShowListScreen() {
        let navController = UINavigationController()
        let sut = AppCoordinator(navigationController: navController)
        sut.showListScreen()
        let isItemListVC = navController.topViewController is ItemListViewController
        XCTAssertTrue(isItemListVC)
    }
    
    func testShowLoginScreen() {
        let navController = UINavigationController()
        let sut = AppCoordinator(navigationController: navController)
        sut.showLoginScreen()
        let isLoginVC = navController.topViewController is LoginViewController
        XCTAssertTrue(isLoginVC)
    }
}
