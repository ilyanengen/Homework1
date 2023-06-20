//
//  ItemService.swift
//  Homework1
//
//  Created by Ilia Biltuev on 20.06.2023.
//

import Foundation

protocol ItemServiceInterface {
    func fetchStrings(completion: @escaping(Result<[String], Error>) -> Void)
}

class ItemService: ItemServiceInterface {
    func fetchStrings(completion: @escaping(Result<[String], Error>) -> Void) {
        guard let url = URL(string: "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new") else {
            completion(.failure(ItemError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(ItemError.invalidResponse))
                return
            }
            
            if let data {
                guard let fetchedString = String(data: data, encoding: .utf8) else {
                    completion(.failure(ItemError.parsingFailed))
                    return
                }
                let strings = fetchedString.components(separatedBy: "\n")
                completion(.success(strings))
            } else {
                completion(.failure(ItemError.noData))
            }
        }
        task.resume()
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
