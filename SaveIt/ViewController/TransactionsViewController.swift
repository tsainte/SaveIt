//
//  TransactionsViewController.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {

    var viewModel: TransactionsViewModel!

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        viewModel.reloadData()
    }
}

// MARK: Configure views
extension TransactionsViewController {
    func configureTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TransactionTableViewCell")
        setupRefreshControl()
    }
}

extension TransactionsViewController: Refreshable {

    func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.reloadData()
    }
}

extension TransactionsViewController: TransactionsViewModelDelegate {
    func refreshUI() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}

extension TransactionsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell")
                as? TransactionTableViewCell else { return UITableViewCell() }

        let row = indexPath.row
        cell.nameLabel.text = viewModel.getName(for: row)
        cell.amountLabel.text = viewModel.getAmount(for: row)
        cell.dateLabel.text = viewModel.getDate(for: row)
        cell.amountLabel.textColor = viewModel.getAmountColor(for: row)
        return cell
    }
}
