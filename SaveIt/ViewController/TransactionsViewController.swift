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

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        tableView.dataSource = self

        viewModel.reloadData()
    }
}

extension TransactionsViewController: TransactionsViewModelDelegate {
    func refreshUI() {
        tableView.reloadData()
    }
}

extension TransactionsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as? TransactionTableViewCell
            else { return UITableViewCell() }

        let row = indexPath.row
        cell.nameLabel.text = viewModel.getName(for: row)
        cell.amountLabel.text = viewModel.getAmount(for: row)
        cell.dateLabel.text = viewModel.getDate(for: row)
        return cell
    }
}
