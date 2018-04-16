//
//  DataManager.swift
//  Watchit Extension
//
//  Created by Tiago Bencardino on 16/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import WatchKit

class DataManager: NSObject {

    static let shared = DataManager()

    var balances: [Balance]

    override init() {
        balances = DataManager.mockBalances()
    }

    //TODO: Remove this method once finished feature
    static func mockBalances() -> [Balance] {
        return [Balance(amount: "£233.42", lastUpdate: "12/02 13:40", image: "icon_monzo"),
                Balance(amount: "-£9.61", lastUpdate: "18/02 17:31", image: "icon_starling"),
                Balance(amount: "-£29.63", lastUpdate: "03/02 11:55", image: "icon_revolut"),
                Balance(amount: "£992.22", lastUpdate: "13/02 14:39", image: "icon_hsbc"),
                Balance(amount: "£15.07", lastUpdate: "26/02 07:27", image: "icon_lloyds")]
    }

    func balancesFrom(_ data: [String: Any]) {
        var newBalances = [Balance]()
        guard let balancesDict = data["balances"] as? [[String: String]] else {
            print("Data from iOS device in wrong format: no array")
            return
        }

        for balanceDict in balancesDict {
            guard let amount = balanceDict["amount"],
                let lastUpdate = balanceDict["lastUpdate"],
                let image = balanceDict["image"] else {
                    print("Data from iOS device in wrong format: wrong balance")
                    return
            }
            let balance = Balance(amount: amount, lastUpdate: lastUpdate, image: image)
            newBalances.append(balance)
        }
        balances = newBalances
    }
}
