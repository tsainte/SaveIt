//
//  MonzoParser.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 17/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

class MonzoParser: NSObject {

}

extension MonzoParser: BankParser {
    func parseAccounts(from data: Data) throws -> [Account] {
        return [Account()]
    }

    func parseBalance(from data: Data, account: Account) throws -> Balance {
        return Balance()
    }

    func parseTransactions(from data: Data, account: Account) throws -> [Transaction] {
        let dict = try JSONDecoder().decode([String: [MonzoTransaction]].self, from: data)
        let transactions = dict["transactions"]?.map {
            Transaction(monzoTransaction: $0, account: account)
        }
        guard let validTransactions = transactions else { throw BankError.noTransactions }
        return validTransactions
    }

    func parseError(from data: Data) throws -> BankError {
        let error = try JSONDecoder().decode(MonzoError.self, from: data)
        return .error(localizedDescription: error.errorDescription ?? "")
    }
}
