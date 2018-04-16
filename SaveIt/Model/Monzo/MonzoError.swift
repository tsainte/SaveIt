//
//  MonzoError.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 15/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

struct MonzoError: Decodable {

    let error: String?
    let errorDescription: String?
    let message: String?
    let code: String?

    enum CodingKeys: String, CodingKey {
        case error
        case message
        case code
        case errorDescription = "error_description"
    }
}
