//
//  StarlingBalance.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 07/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

struct StarlingBalance: Decodable {

    let clearedBalance: Double
    let effectiveBalance: Double
    let pendingTransactions: Double
    let availableToSpend: Double
    let currency: String
    let amount: Double
}
