//
//  BankParser.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 17/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

protocol BankParser {
    func parseAccounts(from data: Data) throws -> [Account]
    func parseBalance(from data: Data, account: Account) throws -> Balance
    func parseTransactions(from data: Data, account: Account) throws -> [Transaction]

    func parseError(from data: Data) throws -> BankError
}
