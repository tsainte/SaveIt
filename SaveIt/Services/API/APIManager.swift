//
//  APIManager.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

class APIManager: NSObject {

    static let shared = APIManager()

    // Injecting token onto the API services if available
    let monzoAPI = MonzoAPI(with: DatabaseManager.getToken(for: Bank.monzo.name))
    let starlingAPI = StarlingAPI(with: DatabaseManager.getToken(for: Bank.starling.name))
    let revolutAPI = RevolutAPI(with: DatabaseManager.getToken(for: Bank.revolut.name))

    func bankApi(from bank: Bank) -> BankAPI? { 
        switch bank.name {
        case Bank.monzo.name:
            return monzoAPI
        case Bank.starling.name:
            return starlingAPI
        case Bank.revolut.name:
            return revolutAPI
        default:
            return nil
        }
    }
}

// MARK: Fetch tokens
extension APIManager {

    func fetchMonzoToken(from url: URL) {
        monzoAPI.getAuhenticationToken(from: url) { [unowned self] monzoToken in
            guard let monzoToken = monzoToken else { print("no token returned"); return }

            let token = Token(monzoToken: monzoToken)
            self.monzoAPI.token = token
            DatabaseManager.updateToken(token)
        }
    }

    func fetchStarlingToken() {
        starlingAPI.addDeveloperToken { [unowned self] token in
            self.starlingAPI.token = token
            DatabaseManager.updateToken(token)
        }
    }
}

// MARK: Fetch accounts
extension APIManager {

    func fetchAllAccounts() {
        fetchAccounts(for: monzoAPI)
        fetchAccounts(for: starlingAPI)
    }

    func fetchAccounts(for bankAPI: BankAPI) {
        let failure: (BankError) -> Void = { (error) in
            print(error)
        }

        bankAPI.getAccounts(success: { (accounts) in
            for account in accounts {
                bankAPI.getBalance(account: account, success: { (balance) in
                    account.balance = balance
                    DatabaseManager.saveAccount(account)
                    DatabaseManager.updateWatch()
                }, failure: failure)
            }
        }, failure: failure)
    }
}

// MARK: Fetch transactions
extension APIManager {

    func fetchTransactions(for account: Account) {
        let failure: (BankError) -> Void = { (error) in
            print(error)
        }

        guard let bank = account.bank,
            let api = bankApi(from: bank) else {
                print("something is nil")
            return
        }
        api.getTransactions(
            account: account,
            success: { (transactions) in
                DatabaseManager.saveTransactions(transactions, with: account)
        },
            failure: failure)
    }
}
