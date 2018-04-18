//
//  Account.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 27/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import RealmSwift

class Account: Object {

    @objc dynamic var bank: Bank?

    @objc dynamic var accountId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var sortCode: String?
    @objc dynamic var accountNumber: String?

    @objc dynamic var balance: Balance?

    convenience init(bank: Bank,
                     accountId: String,
                     name: String,
                     sortCode: String? = nil,
                     accountNumber: String? = nil,
                     balance: Balance? = nil) {
        self.init()
        self.bank = bank
        self.accountId = accountId
        self.name = name
        self.sortCode = sortCode
        self.accountNumber = accountNumber
        self.balance = balance
    }

    convenience init(monzoAccount: MonzoAccount) {
        self.init(bank: .monzo,
                  accountId: monzoAccount.id,
                  name: monzoAccount.type,
                  sortCode: monzoAccount.sortCode,
                  accountNumber: monzoAccount.accountNumber)
    }

    convenience init(starlingAccount: StarlingAccount) {
        self.init(bank: .starling,
                  accountId: starlingAccount.id,
                  name: starlingAccount.name,
                  sortCode: starlingAccount.sortCode,
                  accountNumber: starlingAccount.accountNumber)
    }

    override static func primaryKey() -> String? {
        return "accountId"
    }
}

// MARK: Apple Watch format
extension Account {
    func watchDescription() -> [String: String]? {
        if let balance = self.balance, let bank = self.bank {
            return ["amount": String(format: "£ %.02f", balance.amount),
                    "lastUpdate": balance.lastUpdate.toString(style: .short),
                    "image": bank.icon]
        } else {
            return nil
        }
    }
}
