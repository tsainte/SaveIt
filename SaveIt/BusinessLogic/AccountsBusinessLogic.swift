//
//  AccountsBusinessLogic.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 28/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class AccountsBusinessLogic: NSObject {

    let apiManager = APIManager.shared
    
    func fetchAccounts() {
        apiManager.fetchAllAccounts()
    }
}
