//
//  StarlingAccount.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 07/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

struct StarlingAccount: Decodable {

    let id: String
    let name: String
    let created: Date
    let accountNumber: String
    let sortCode: String
    let iban: String
    let bic: String
    let currency: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case created = "createdAt"
        case accountNumber
        case sortCode
        case iban
        case bic
        case currency
    }

}
