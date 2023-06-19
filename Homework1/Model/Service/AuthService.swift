//
//  AuthService.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import Foundation

protocol AuthServiceInterface {
    func signIn(username: String, password: String, completion: @escaping(Result<Void, AuthError>) -> Void)
}

class AuthService: AuthServiceInterface {
    func signIn(username: String, password: String, completion: @escaping(Result<Void, AuthError>) -> Void) {
        // Hardcoded credentials
        if username == "user" && password == "123qwe" {
            completion(.success(()))
        } else {
            completion(.failure(.invalidCredentials))
        }
    }
}

enum AuthError: Error {
    case invalidCredentials
    case unknown
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return NSLocalizedString("Invalid credentials", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
