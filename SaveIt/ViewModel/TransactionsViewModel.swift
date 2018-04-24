//
//  TransactionsViewModel.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import RealmSwift

protocol TransactionsViewModelDelegate: class {
    func refreshUI()
}

class TransactionsViewModel: NSObject {

    let account: Account

    var notificationToken: NotificationToken?
    var transactions: [Transaction]?

    let businessLogic: TransactionsBusinessLogic!
    weak var delegate: TransactionsViewModelDelegate?

    init(account: Account) {
        self.account = account
        businessLogic = TransactionsBusinessLogic(with: account)
        transactions = DatabaseManager.transactions(account: self.account)
        super.init()
        setupRealmObserver()
    }
}

extension TransactionsViewModel: ViewModelConnector {

    func setupRealmObserver() {
        notificationToken = DatabaseManager.realm.observe { _, _ in
            self.transactions = DatabaseManager.transactions(account: self.account)
            self.delegate?.refreshUI()
        }
    }

    func reloadData() {
        businessLogic.fetchTransactions()
    }
}

extension TransactionsViewModel {
    var numberOfRows: Int {
        return transactions?.count ?? 0
    }
}

// Cell bindings
extension TransactionsViewModel {
    func getName(for row: Int) -> String {
        return transactions?[row].name ?? "---"
    }

    func getAmount(for row: Int) -> String {
        guard let transaction = transactions?[row] else { return "£ 0.00" }
        let absAmount = abs(transaction.amount)
        let sign = transaction.amount > 0 ? "+" : ""
        let currency = transaction.currency == "GBP" ? "£" : transaction.currency //TODO: do it properly
        return String(format: "%@ %@ %.2f", sign, currency, absAmount)
    }

    func getDate(for row: Int) -> String {
        return transactions?[row].created.toString(style: .short) ?? "---"
    }

    func getAmountColor(for row: Int) -> UIColor {
        guard let amount = transactions?[row].amount else { return .darkGray }
        return amount > 0 ? UIColor.FlatColor.Green.Fern : .darkGray
    }
}
