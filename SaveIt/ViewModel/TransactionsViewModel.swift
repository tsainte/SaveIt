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
        super.init()
        setupRealmObserver()
    }
}

extension TransactionsViewModel: ViewModelConnector {

    func setupRealmObserver() {
        notificationToken = DatabaseManager.realm.observe { _, _ in
            self.transactions = DatabaseManager.transactions(account: self.account)
            self.refreshUI()
        }
    }

    func reloadData() {
        businessLogic.fetchTransactions()
    }

    func refreshUI() {
        self.delegate?.refreshUI()
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
        return String(format: "%.2f", transactions?[row].amount ?? 0)
    }

    func getDate(for row: Int) -> String {
        return transactions?[row].created.toString(style: .short) ?? "---"
    }
}
