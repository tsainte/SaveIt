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
        case Bank.monzo.name:
            APIManager.shared.monzoAPI.requestAuthenticationCode()
        case Bank.starling.name:
            APIManager.shared.fetchStarlingToken()
        default:
            print("no service found for \(bank)")
        }
    }

    func logoutService(bank: String) {
        print("logout \(bank)")
    }
}
