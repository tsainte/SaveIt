//
//  InterfaceController.swift
//  Watchit Extension
//
//  Created by Tiago Bencardino on 23/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import WatchKit

class BalancesInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!

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

extension BalancesInterfaceController {

    private func loadTableData() {
        let balances = DataManager.shared.balances

        table.setNumberOfRows(balances.count, withRowType: "BalanceRowController")
        for (index, balance) in balances.enumerated() {
            guard let row = table.rowController(at: index) as? BalanceRowController else { return }
            row.amount.setText(balance.amount)
            row.lastUpdate.setText(balance.lastUpdate)
            row.logo.setImage(UIImage(named: balance.image))
        }
    }
}
