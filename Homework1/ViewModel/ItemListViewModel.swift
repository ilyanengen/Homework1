//
//  ItemListViewModel.swift
//  Homework1
//
//  Created by Ilia Biltuev on 20.06.2023.
//

import Foundation

protocol ItemListViewModelInterface {
    func fetchStrings()
}

class ItemListViewModel: ItemListViewModelInterface {
    weak var view: ItemListViewInterface?
    
    var itemService: ItemServiceInterface
    
    init(itemService: ItemServiceInterface) {
        self.itemService = itemService
    }
    
    func fetchStrings() {
        // TODO: load -> update view with fetched strings
        let fetchedStrings = ["sadasdas","ssssaaaaa", "kkkhgfds", "ghgjhs"]
        view?.updateList(items: fetchedStrings)
    }
}
