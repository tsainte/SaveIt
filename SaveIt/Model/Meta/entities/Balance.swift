//
//  Balance.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 27/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation
import RealmSwift

class Balance: Object {
    
    @objc dynamic var accountId: String = ""
    @objc dynamic var amount: Double = 0
    @objc dynamic var currency: String = ""
    @objc dynamic var lastUpdate: Date = Date()
    
    convenience init(accountId: String, amount: Double, currency: String, lastUpdate: Date) {
        self.init()
        self.accountId = accountId
        self.amount = amount
        self.currency = currency
        self.lastUpdate = lastUpdate
    }
    
    convenience init(monzoBalance: MonzoBalance, accountId: String) {
        self.init(accountId: accountId,
                  amount: monzoBalance.amount/100,
                  currency: monzoBalance.currency,
                  lastUpdate: Date())
    }
    
    convenience init(starlingBalance: StarlingBalance, accountId: String) {
        self.init(accountId: accountId,
                  amount: starlingBalance.effectiveBalance,
                  currency: starlingBalance.currency,
                  lastUpdate: Date())
    }
    
    override static func primaryKey() -> String? {
        return "accountId"
    }
}
