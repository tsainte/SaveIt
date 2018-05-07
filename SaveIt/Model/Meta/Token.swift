//
//  Token.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 01/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation
import RealmSwift

protocol TokenProtocol {
    var bank: Bank! { get set }
    var accessToken: String! { get set }
}

class Token: Object {

    @objc dynamic var bank: String = ""
    @objc dynamic var accessToken: String = ""

    convenience init(bank: Bank, accessToken: String) {
        self.init()
        self.bank = bank.name
        self.accessToken = accessToken
    }

    convenience init(monzoToken: MonzoToken) {
        self.init(bank: .monzo, accessToken: monzoToken.accessToken)
    }

    convenience init(starlingToken: StarlingToken) {
        self.init(bank: .starling, accessToken: starlingToken.accessToken)
    }

    convenience init(starlingDeveloperToken: String) {
        self.init(bank: .starling, accessToken: starlingDeveloperToken)
    }

    override static func primaryKey() -> String? {
        return "bank"
    }
}
