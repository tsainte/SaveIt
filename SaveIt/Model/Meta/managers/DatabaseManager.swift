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

    static var realm: Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            print("Could not access database: ", error)
        }
        return self.realm
    }

    public static func write(realm: Realm, writeClosure: () -> Void) {
        do {
            try realm.write {
                writeClosure()
            }
        } catch {
            print("Could not write to database: ", error)
        }
    }

    static var filePath: URL? {
        return realm.configuration.fileURL
    }
}

// MARK: Handling tokens
extension DatabaseManager {

    static func getToken(for bank: String) -> Token? {
        return realm.objects(Token.self).filter("bank == '\(bank)'").last
    }

    static func saveToken(_ token: Token) {
        write(realm: realm) {
            realm.add(token)
        }
    }

    // Updates token for a particular bank
    static func updateToken(_ token: Token) {
        if let oldToken = getToken(for: token.bank) {
            write(realm: realm) {
                oldToken.accessToken = token.accessToken
                realm.add(oldToken, update: true)
                print("token updated: \(token.accessToken)")
            }
        } else {
            write(realm: realm) {
                realm.add(token)
                print("token added: \(token.accessToken)")
            }
        }
    }
}

// MARK: Handling accounts
extension DatabaseManager {

    static func accounts() -> [Account] {
        return Array(realm.objects(Account.self))
    }

    static func saveAccount(_ account: Account) {
        write(realm: realm) {
            realm.add(account, update: true)
        }
    }
}
