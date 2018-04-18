//
//  RevolutParser.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 17/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

class RevolutParser: NSObject {

}

extension RevolutParser: BankParser {
    func parseAccounts(from data: Data) throws -> [Account] {
        return [Account()]
    }

    func parseBalance(from data: Data, account: Account) throws -> Balance {
        return Balance()
    }

    func parseTransactions(from data: Data, account: Account) throws -> [Transaction] {
        return [Transaction()]
    }

    func parseError(from data: Data) throws -> BankError {
        return .notImplemented
    }

}
