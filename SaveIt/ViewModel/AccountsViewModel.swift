//
//  AccountsViewModel.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 27/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation
import AFDateHelper
import RealmSwift

protocol AccountsViewModelDelegate: class {
    func refreshUI()
}

class AccountsViewModel: NSObject {

    weak var delegate: AccountsViewModelDelegate?
    var notificationToken: NotificationToken?

    var accounts = DatabaseManager.accounts()
    let businessLogic = AccountsBusinessLogic()

    var numberOfRows: Int {
        return accounts.count
    }

    init(delegate: AccountsViewModelDelegate) {
        self.delegate = delegate
        self.accounts = DatabaseManager.accounts()
        super.init()
        setupRealmObserver()
        reloadData()
    }

    deinit {
        notificationToken?.invalidate()
    }
}

extension AccountsViewModel: ViewModelConnector {

    func setupRealmObserver() {
        notificationToken = DatabaseManager.realm.observe { _, _ in
            self.accounts = DatabaseManager.accounts()
            self.delegate?.refreshUI()
        }
    }

    func reloadData() {
        businessLogic.fetchAccounts()
    }
}

// MARK: cell bindings
extension AccountsViewModel {

    func getLogo(row: Int) -> String {
        return accounts[row].bank?.icon ?? ""
    }

    func getAccountName(row: Int) -> String {
        let account = accounts[row]
        return account.bank?.name ?? ""
    }

    func getLastUpdate(row: Int) -> String {
        return "Last update: " + (accounts[row].balance?.lastUpdate.toString(style: .short) ?? "---")
    }

    func getAmount(row: Int) -> String {
        //TODO: create extension to convert balance properly
        guard let amount = accounts[row].balance?.amount else { return "---" }
        return String(format: "£ %.02f", amount)
    }

    func getSortCode(row: Int) -> String {
        let noSortCode = "---"
        guard let sortCode = accounts[row].sortCode, sortCode.count == 6 else { return noSortCode }
        var formattedSortCode = ""
        for (index, char) in sortCode.enumerated() {
            formattedSortCode += String(char)
            if index < 5 && index % 2 == 1 {
                formattedSortCode += "-"
            }
        }
        return formattedSortCode
    }

    func getAccountNumber(row: Int) -> String {
        return accounts[row].accountNumber ?? "---"
    }
}

// MARK: other bindings
extension AccountsViewModel {

    func transactionsViewModel(row: Int) -> TransactionsViewModel {
        return TransactionsViewModel(account: accounts[row])
    }
}
