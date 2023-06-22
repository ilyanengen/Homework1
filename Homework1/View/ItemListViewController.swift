//
//  ItemListViewController.swift
//  Homework1
//
//  Created by Ilia Biltuev on 14.06.2023.
//

import UIKit

protocol ItemListViewInterface: AnyObject {
    var viewModel: ItemListViewModelInterface? { get set }
    func updateList(items: [String])
    func showErrorAlert(error: Error)
}

class ItemListViewController: UIViewController, ItemListViewInterface {
    var viewModel: ItemListViewModelInterface?
    weak var delegate: AppCoordinatorDelegate?
    
    private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel?.fetchStrings()
    }
    
    func updateList(items: [String]) {
        refreshTableView(with: items)
    }
    
    func showErrorAlert(error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        errorAlert.addAction(.init(title: "OK", style: .default))
        present(errorAlert, animated: true)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        view.addSubview(tableView)
        
        dataSource = UITableViewDiffableDataSource<Int, String>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = item
            return cell
        }
        
        refreshTableView(with: [])
    }

    private func refreshTableView(with items: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
