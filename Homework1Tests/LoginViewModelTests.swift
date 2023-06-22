//
//  LoginViewModelTests.swift
//  Homework1Tests
//
//  Created by Ilia Biltuev on 22.06.2023.
//

import XCTest
@testable import Homework1

final class LoginViewModelTests: XCTestCase {
    func testSignInInvalidCredentials() {
        let sut = LoginViewModel(username: "hello", password: "world!", authService: AuthService())
        
        let view = MockLoginView()
        view.viewModel = sut
        sut.view = view
        
        sut.signIn()
        
        XCTAssertEqual(view.receivedError?.localizedDescription, AuthError.invalidCredentials.localizedDescription)
        XCTAssertEqual((view.receivedError as? NSError)?.code, (AuthError.invalidCredentials as NSError).code)
    }
    
    func testSuccessfulSignIn() {
        let sut = LoginViewModel(username: "user", password: "123qwe", authService: AuthService())

        let view = MockLoginView()
        view.viewModel = sut
        sut.view = view
        
        sut.signIn()
        XCTAssertTrue(view.isSuccess)
    }
}

final class MockLoginView: LoginViewInterface {
    var viewModel: LoginViewModelInterface?
    
    var receivedError: Error?
    var isSuccess: Bool = false
    
    func showErrorAlert(error: Error) {
        receivedError = error
    }
    
    func didSignInSuccessfully() {
        isSuccess = true
    }
}
