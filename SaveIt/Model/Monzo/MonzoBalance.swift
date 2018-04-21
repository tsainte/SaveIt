//
//  MonzoBalance.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 23/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

struct MonzoBalance: Decodable {

    let amount: Double
    let currency: String
    let spendToday: Double?

    enum CodingKeys: String, CodingKey {
        case amount = "balance"
        case currency
        case spendToday = "spend_today"
    }
}
