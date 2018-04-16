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
    var notificationToken: NotificationToken? = nil

    let accounts = DatabaseManager.accounts()
    let businessLogic = AccountsBusinessLogic()

    var numberOfRows: Int {
        return accounts.count
    }

    init(delegate: AccountsViewModelDelegate) {
        self.delegate = delegate
        notificationToken = DatabaseManager.realm.observe { notification, realm in
            delegate.refreshUI()
        }

        businessLogic.fetchAccounts()
    }

    deinit {
        notificationToken?.invalidate()
    }

    func refreshData() {
        businessLogic.fetchAccounts()
    }

}

// MARK: cell bindings
extension AccountsViewModel {

    func getLogo(row: Int) -> String {
        return accounts[row].bank!.icon
    }

    func getAccountName(row: Int) -> String {
        return accounts[row].name
    }

    func getLastUpdate(row: Int) -> String {
        return "Last update: " + (accounts[row].balance?.lastUpdate.toString(style: .short) ?? "---")
    }

    func getAmount(row: Int) -> String {
        //TODO: create extension to convert balance properly
        guard let amount = accounts[row].balance?.amount else { return "---" }
        return String(format: "£ %.02f", amount)
    }
}
