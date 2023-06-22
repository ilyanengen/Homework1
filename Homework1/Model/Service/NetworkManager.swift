//
//  NetworkManager.swift
//  Homework1
//
//  Created by Ilia Biltuev on 22.06.2023.
//

import Foundation

protocol NetworkManagerInterface {
    func dataTask(url: URL, completion: @escaping(Result<Data, Error>) -> Void)
}

class NetworkManager: NetworkManagerInterface {
    func dataTask(url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
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
                completion(.success(data))
            } else {
                completion(.failure(ItemError.noData))
            }
        }
        task.resume()
    }
}
