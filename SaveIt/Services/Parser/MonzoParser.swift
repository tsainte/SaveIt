//
//  MonzoParser.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 17/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

class MonzoParser: NSObject {

    static var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .custom(DateHandler.dateDecoding)
        return jsonDecoder
    }
}

extension MonzoParser: BankParser {
    func parseAccounts(from data: Data) throws -> [Account] {
        let dict = try MonzoParser.decoder.decode([String: [MonzoAccount]].self, from: data)
        let accounts = dict["accounts"]?.map { Account(monzoAccount: $0) }

        guard let validAccounts = accounts else { throw BankError.noAccounts }
        return validAccounts
    }

    func parseBalance(from data: Data, account: Account) throws -> Balance {
        let monzoBalance = try MonzoParser.decoder.decode(MonzoBalance.self, from: data)
        let balance = Balance(monzoBalance: monzoBalance, accountId: account.accountId)
        return balance
    }

    func parseTransactions(from data: Data, account: Account) throws -> [Transaction] {
        let dict = try MonzoParser.decoder.decode([String: [MonzoTransaction]].self, from: data)
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
