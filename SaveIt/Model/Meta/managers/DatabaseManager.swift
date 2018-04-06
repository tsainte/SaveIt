//
//  DatabaseManager.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 27/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager: NSObject {

    public static let shared = DatabaseManager()
    
    public let realm = try! Realm()
    
    var filePath: URL? {
        return realm.configuration.fileURL
    }
}

// MARK: Handling tokens
extension DatabaseManager {
    
    func getToken(for bank: String) -> Token? {
        return realm.objects(Token.self).filter("bank == '\(bank)'").last
    }
    
    func saveToken(_ token: Token) {
        try! realm.write {
            realm.add(token)
        }
    }
    
    // Updates token for a particular bank
    func updateToken(_ token: Token) {
        if let oldToken = getToken(for: token.bank) {
            try! realm.write {
                oldToken.accessToken = token.accessToken
                realm.add(oldToken, update: true)
                print("token updated: \(token.accessToken)")
            }
        } else {
            try! realm.write {
                realm.add(token)
                print("token added: \(token.accessToken)")
            }
        }
    }
}

// MARK: Handling accounts
extension DatabaseManager {
    
    func accounts() -> [Account] {
        return Array(realm.objects(Account.self))
    }
    
    func saveAccount(_ account: Account) {
        try! realm.write {
            realm.add(account, update: true)
        }
    }
}
