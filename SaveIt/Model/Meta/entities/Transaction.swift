//
//  Transaction.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 17/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation
import RealmSwift

class Transaction: Object {

    @objc dynamic var account: Account = Account()

    @objc dynamic var id: String = ""
    @objc dynamic var amount: Double = 0
    @objc dynamic var balance: Double = 0
    @objc dynamic var currency: String = ""
    @objc dynamic var name: String = ""

    convenience init(account: Account,
                     id: String,
                     amount: Double,
                     balance: Double,
                     currency: String,
                     name: String) {
        self.init()
        self.account = account
        self.id = id
        self.amount = amount
        self.balance = balance
        self.currency = currency
        self.name = name
    }

    convenience init(monzoTransaction: MonzoTransaction, account: Account) {
        self.init(account: account,
                  id: monzoTransaction.id,
                  amount: monzoTransaction.amount / 100,
                  balance: monzoTransaction.accountBalance / 100,
                  currency: monzoTransaction.currency,
                  name: monzoTransaction.notes)
    }

    convenience init(starlingTransaction: StarlingTransaction, account: Account) {
        self.init(account: account,
                  id: starlingTransaction.id,
                  amount: starlingTransaction.amount,
                  balance: starlingTransaction.balance,
                  currency: starlingTransaction.currency,
                  name: starlingTransaction.narrative)
    }
}
