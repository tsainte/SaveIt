//
//  MonzoToken.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 15/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

struct MonzoToken: Decodable, TokenProtocol {
    
    var bank: Bank! = BankList.monzo
    var accessToken: String!
    
    let clientId: String
    let expiresIn: Double
    let refreshToken: String?
    let tokenType: String
    let userId: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case clientId = "client_id"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case userId = "user_id"
        case tokenType = "token_type"
    }
}

extension MonzoToken: CustomStringConvertible {
    var description: String {
        return "accessToken: \(accessToken), clientId: \(clientId), expiresIn: \(expiresIn), refreshToken: \(refreshToken ?? ""), tokenType: \(tokenType), userId: \(userId)"
    }
}
