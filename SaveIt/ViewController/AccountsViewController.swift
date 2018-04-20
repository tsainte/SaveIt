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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = .red

        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = AccountsViewModel(delegate: self)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "AccountTableViewCell")
        tableView.addSubview(refreshControl)
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "TransactionsViewController" {
            guard
                let transactionsVC = segue.destination as? TransactionsViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }

            transactionsVC.viewModel = viewModel.transactionsViewModel(row: indexPath.row)
        }
    }
}

extension AccountsViewController: AccountsViewModelDelegate {

    func refreshUI() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

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

extension AccountsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TransactionsViewController", sender: tableView)
    }
}
