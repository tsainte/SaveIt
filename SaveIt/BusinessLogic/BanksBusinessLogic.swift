//
//  BanksBusinessLogic.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 05/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

class BanksBusinessLogic: NSObject {

    func loginService(bank: String) {
        switch bank {
        case BankList.monzo.name:
            APIManager.shared.monzo.requestAuthenticationCode()
        case BankList.starling.name:
            APIManager.shared.fetchStarlingToken()
        default:
            print("no service found for \(bank)")
        }
    }

    func logoutService(bank: String) {
        print("logout \(bank)")
    }
}
