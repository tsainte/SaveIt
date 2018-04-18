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
    let monzo = MonzoAPI(with: DatabaseManager.getToken(for: Bank.monzo.name))
    let starling = StarlingAPI(with: DatabaseManager.getToken(for: Bank.starling.name))
    let revolut = RevolutAPI(with: DatabaseManager.getToken(for: Bank.revolut.name))

    func bankApi(from bank: Bank) -> BankAPI? {
        switch bank {
        case .monzo:
            return monzo
        case .starling:
            return starling
        case .revolut:
            return revolut
        default: return nil
        }
    }
}

// MARK: Fetch tokens
extension APIManager {

    func fetchMonzoToken(from url: URL) {
        monzo.getAuhenticationToken(from: url) { [unowned self] monzoToken in
            guard let monzoToken = monzoToken else { print("no token returned"); return }

            let token = Token(monzoToken: monzoToken)
            self.monzo.token = token
            DatabaseManager.updateToken(token)
        }
    }

    func fetchStarlingToken() {
        starling.addDeveloperToken { [unowned self] token in
            self.starling.token = token
            DatabaseManager.updateToken(token)
        }
    }
}

// MARK: Fetch accounts
extension APIManager {

    func fetchAllAccounts() {
        fetchAccounts(for: monzo)
        fetchAccounts(for: starling)
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

    func fetchTransactions(for bank: Bank) {
//        guard let api = bankApi(from: bank) else { return }
//        api.get

    }
}
