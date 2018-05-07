//
//  StarlingToken.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 07/05/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class StarlingToken: Decodable, TokenProtocol {
    var bank: Bank! = .starling
    var accessToken: String!

    let expiresIn: Double
    let refreshToken: String?
    let tokenType: String
    let scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope = "scope"
    }
}
