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
    
    private let itemService: ItemServiceInterface
    
    init(itemService: ItemServiceInterface) {
        self.itemService = itemService
    }
    
    func fetchStrings() {
        itemService.fetchStrings { [weak self] result in
            switch result {
            case .success(let strings):
                self?.view?.updateList(items: strings)
            case .failure(let error):
                self?.view?.showErrorAlert(error: error)
            }
        }
    }
}
