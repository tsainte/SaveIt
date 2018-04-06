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
    
    static let db = DatabaseManager.shared
    
    // Injecting token onto the API services if available
    let monzo = MonzoAPI(with: db.getToken(for: BankList.monzo.name))
    let starling = StarlingAPI(with: db.getToken(for: BankList.starling.name))
    let revolut = RevolutAPI(with: db.getToken(for: BankList.revolut.name))
}

// MARK: Fetch tokens
extension APIManager {
    
    func fetchMonzoToken(from url: URL) {
        monzo.getAuhenticationToken(from: url) { [unowned self] monzoToken in
            guard let monzoToken = monzoToken else { print("no token returned"); return }
            
            let token = Token(monzoToken: monzoToken)
            self.monzo.token = token
            DatabaseManager.shared.updateToken(token)
        }
    }
    
    func fetchStarlingToken() {
        starling.addDeveloperToken() { [unowned self] token in
            self.starling.token = token
            DatabaseManager.shared.updateToken(token)
        }
    }
}

// MARK: Fetch accounts
extension APIManager {
    
    func fetchAllAccounts()  {
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
                    DatabaseManager.shared.saveAccount(account)
                }, failure: failure)
            }
        }, failure: failure)
    }

}
