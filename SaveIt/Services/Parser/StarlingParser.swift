//
//  StarlingParser.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 17/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

class StarlingParser: NSObject {

    struct StarlingTransactionResponse: Decodable {
        let _embedded: [String: [StarlingTransaction]]
    }

    static var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .custom(DateHandler.dateDecoding)
        return jsonDecoder
    }
}

extension StarlingParser: BankParser {
    func parseAccounts(from data: Data) throws -> [Account] {
        let starlingAccount = try StarlingParser.decoder.decode(StarlingAccount.self, from: data)
        let accounts = [Account(starlingAccount: starlingAccount)]
        return accounts
    }

    func parseBalance(from data: Data, account: Account) throws -> Balance {
        let starlingBalance = try StarlingParser.decoder.decode(StarlingBalance.self, from: data)
        let balance = Balance(starlingBalance: starlingBalance, accountId: account.accountId)
        return balance
    }

    func parseTransactions(from data: Data, account: Account) throws -> [Transaction] {
        let response = try StarlingParser.decoder.decode(StarlingTransactionResponse.self, from: data)
        let transactions = response._embedded["transactions"]?.map {
            Transaction(starlingTransaction: $0, account: account)
        }
        guard let validTransactions = transactions else { throw BankError.noTransactions }
        return validTransactions
    }

    func parseError(from data: Data) throws -> BankError {
        return .notImplemented
    }

}
