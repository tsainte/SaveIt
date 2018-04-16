//
//  MonzoAccount.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 19/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

enum AccountType: String {
    case retail = "uk_retail"
    case prepaid = "uk_prepaid"
}

struct MonzoAccount: Decodable {
    let id: String
    let created: Date
    let owner: String
    let type: String
    let closed: Bool
    let accountNumber: String?
    let sortCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case created
        case closed
        case type
        case owner = "description"
        case accountNumber = "account_number"
        case sortCode = "sort_code"
    }
}
