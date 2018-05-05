//
//  Transaction.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 17/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import RealmSwift

class Transaction: Object {

    @objc dynamic var account: Account?

    @objc dynamic var id: String = ""
    @objc dynamic var amount: Double = 0
    @objc dynamic var balance: Double = 0
    @objc dynamic var currency: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var created: Date = Date()

    convenience init(account: Account,
                     id: String,
                     amount: Double,
                     balance: Double,
                     currency: String,
                     name: String,
                     created: Date) {
        self.init()
        self.account = account
        self.id = id
        self.amount = amount
        self.balance = balance
        self.currency = currency
        self.name = name
        self.created = created
    }

    convenience init(monzoTransaction: MonzoTransaction, account: Account) {
        self.init(account: account,
                  id: monzoTransaction.id,
                  amount: monzoTransaction.amount / 100,
                  balance: monzoTransaction.accountBalance / 100,
                  currency: monzoTransaction.currency,
                  name: monzoTransaction.notes == "" ? monzoTransaction.description : monzoTransaction.notes,
                  created: monzoTransaction.created)
    }

    convenience init(starlingTransaction: StarlingTransaction, account: Account) {
        self.init(account: account,
                  id: starlingTransaction.id,
                  amount: starlingTransaction.amount,
                  balance: starlingTransaction.balance,
                  currency: starlingTransaction.currency,
                  name: starlingTransaction.narrative,
                  created: starlingTransaction.created)
    }
}
