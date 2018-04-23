//
//  MonzoTransaction.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 17/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

struct MonzoTransaction: Decodable {
    let accountBalance: Double
    let amount: Double
    let created: Date
    let currency: String
    let description: String
    let id: String
    let merchant: String?
    let notes: String
    let isLoad: Bool
    let category: String
}
