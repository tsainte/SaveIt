//
//  InterfaceController.swift
//  Watchit Extension
//
//  Created by Tiago Bencardino on 23/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import WatchKit

class InterfaceController: WKInterfaceController {

    struct Balance {
        let amount: String!
        let lastUpdate: String!
        let image: String!
    }
    
    @IBOutlet var table: WKInterfaceTable!
    
    let balances: [Balance] = [Balance(amount: "£233.42", lastUpdate: "12/02 13:40", image: "icon_monzo"),
                               Balance(amount: "-£9.61", lastUpdate: "18/02 17:31", image: "icon_starling"),
                               Balance(amount: "-£29.63", lastUpdate: "03/02 11:55", image: "icon_revolut"),
                               Balance(amount: "£992.22", lastUpdate: "13/02 14:39", image: "icon_hsbc"),
                               Balance(amount: "£15.07", lastUpdate: "26/02 07:27", image: "icon_lloyds")]

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        loadTableData()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

extension InterfaceController {

    private func loadTableData() {
        table.setNumberOfRows(balances.count, withRowType: "BalanceRowController")
        for (index, balance) in balances.enumerated() {
            guard let row = table.rowController(at: index) as? BalanceRowController else { return }
            row.amount.setText(balance.amount)
            row.lastUpdate.setText(balance.lastUpdate)
            row.logo.setImage(UIImage(named: balance.image))
        }
    }
}
