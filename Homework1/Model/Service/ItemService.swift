//
//  ItemService.swift
//  Homework1
//
//  Created by Ilia Biltuev on 20.06.2023.
//

import Foundation

protocol ItemServiceInterface {
    var fetchStringsUrl: String { get set }
    func fetchStrings(completion: @escaping(Result<[String], Error>) -> Void)
}

class ItemService: ItemServiceInterface {
    var fetchStringsUrl: String
    private let networkManager: NetworkManagerInterface
    
    init(networkManager: NetworkManagerInterface, fetchStringsUrl: String) {
        self.networkManager = networkManager
        self.fetchStringsUrl = fetchStringsUrl
    }
    
    func fetchStrings(completion: @escaping(Result<[String], Error>) -> Void) {
        guard let url = URL(string: fetchStringsUrl) else {
            completion(.failure(ItemError.invalidURL))
            return
        }
        
        networkManager.dataTask(url: url) { result in
            switch result {
            case .success(let data):
                guard let fetchedString = String(data: data, encoding: .utf8) else {
                    completion(.failure(ItemError.parsingFailed))
                    return
                }
                let strings = fetchedString.components(separatedBy: "\n")
                completion(.success(strings))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum ItemError: Error {
    case invalidURL
    case invalidResponse
    case parsingFailed
    case noData
    case unknown
}

extension ItemError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Invalid response", comment: "")
        case .parsingFailed:
            return NSLocalizedString("Parsing failed", comment: "")
        case .noData:
            return NSLocalizedString("No data in response", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
