//
//  StarlingTransaction.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 17/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

struct StarlingTransaction: Decodable {
    let id: String
    let currency: String
    let amount: Double
    let direction: String
    let created: Date
    let narrative: String
    let source: String
    let balance: Double
}
