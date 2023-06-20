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
        
    }
}
