//
//  LoginViewController.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import UIKit

protocol LoginViewControllerInterface {
    var viewModel: LoginViewModelInterface? { get set }
}

class LoginViewController: UIViewController, LoginViewControllerInterface {
    var viewModel: LoginViewModelInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
