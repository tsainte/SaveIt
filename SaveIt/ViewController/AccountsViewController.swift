//
//  AccountsViewController.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 27/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: AccountsViewModel!
    var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = AccountsViewModel(delegate: self)
        configureTableView()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "TransactionsViewController" {
            guard
                let transactionsVC = segue.destination as? TransactionsViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }

            transactionsVC.viewModel = viewModel.transactionsViewModel(row: indexPath.row)
            transactionsVC.viewModel.delegate = transactionsVC
        }
    }
}

// MARK: Setup controls
extension AccountsViewController {
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "AccountTableViewCell")
        setupRefreshControl()
    }
}

// MARK: Refreshable protocol
extension AccountsViewController: Refreshable {

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.reloadData()
    }
}

// MARK: View model delegate
extension AccountsViewController: AccountsViewModelDelegate {

    func refreshUI() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}

// MARK: Table view data source
extension AccountsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell",
                                                       for: indexPath) as? AccountTableViewCell else {
            print("cant take the cell")
            return UITableViewCell()
        }

        let row = indexPath.row
        cell.accountName.text = viewModel.getAccountName(row: row)
        cell.amount.text = viewModel.getAmount(row: row)
        cell.logo.image = UIImage(named: viewModel.getLogo(row: row))
        cell.lastUpdate.text = viewModel.getLastUpdate(row: row)
        return cell
    }
}

// MARK: Table view delegate
extension AccountsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TransactionsViewController", sender: tableView)
    }
}
