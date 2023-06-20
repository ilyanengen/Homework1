//
//  ItemListViewController.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import UIKit

protocol ItemListViewInterface: AnyObject {
    var viewModel: ItemListViewModelInterface? { get set }
    func showErrorAlert(error: Error)
}

class ItemListViewController: UIViewController, ItemListViewInterface {
    var viewModel: ItemListViewModelInterface?
    weak var delegate: AppCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchStrings()
    }
    
    func showErrorAlert(error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        errorAlert.addAction(.init(title: "OK", style: .default))
        present(errorAlert, animated: true)
    }
}
