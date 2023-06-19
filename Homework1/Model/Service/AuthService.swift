//
//  AuthService.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import Foundation

protocol AuthServiceInterface {
    func signIn(login: String, password: String, completion: @escaping(Result<Data, Error>) -> Void)
}

class AuthService: AuthServiceInterface {
    func signIn(login: String, password: String, completion: @escaping(Result<Data, Error>) -> Void) {
        // TODO:
    }
}
