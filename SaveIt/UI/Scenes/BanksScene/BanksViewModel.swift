//
//  BanksViewModel.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 01/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class BankDataModel {
    let logo: String!
    let bankName: String!
    var status: Bool!

    init(bank: Bank, status: Bool) {
        self.logo = bank.icon
        self.bankName = bank.name
        self.status = status
    }
}

class BanksViewModel: NSObject {

    let dataModels = [BankDataModel(bank: .monzo, status: false),
                      BankDataModel(bank: .starling, status: false),
                      BankDataModel(bank: .revolut, status: false),
                      BankDataModel(bank: .hsbc, status: false),
                      BankDataModel(bank: .lloyds, status: false)]

    let businessLogic = BanksBusinessLogic()

}

// MARK: Table View Bindings

extension BanksViewModel {

    var numberOfRows: Int {
        return dataModels.count
    }

    func logo(for row: Int) -> String {
        return dataModels[row].logo
    }

    func name(for row: Int) -> String {
        return dataModels[row].bankName
    }

    func status(for row: Int) -> Bool {
        return dataModels[row].status
    }
}

extension BanksViewModel {

    func newStatus(for row: Int, status: Bool) {
        let dataModel = dataModels[row]
        dataModel.status = status

        if status {
            businessLogic.loginService(bank: dataModel.bankName)
        } else {
            businessLogic.logoutService(bank: dataModel.bankName)
        }
    }
}
