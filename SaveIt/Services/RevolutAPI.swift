//
//  RevolutAPI.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 28/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class RevolutAPI: NSObject {

    var token: Token?
    
    required init(with token: Token?) {
        self.token = token
    }
}

// MARK: BankAPI protocol implementation

extension RevolutAPI: BankAPI {
    
    func getAccounts(success: @escaping ([Account]) -> Void, failure: @escaping (BankError) -> Void) {
        failure(.notImplemented)
    }
    
    func getBalance(account: Account, success: @escaping (Balance) -> Void, failure: @escaping(BankError) -> Void) {
        failure(.notImplemented)
    }
}
