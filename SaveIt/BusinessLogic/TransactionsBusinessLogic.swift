//
//  TransactionsBusinessLogic.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class TransactionsBusinessLogic: NSObject {

    let apiManager = APIManager.shared
    let account: Account

    init(with account: Account) {
        self.account = account
    }

    func fetchTransactions() {
        apiManager.fetchTransactions(for: account)
    }

}
