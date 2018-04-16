//
//  AppDelegate.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print("Realm: \(DatabaseManager.filePath!)")
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        APIManager.shared.fetchMonzoToken(from: url)
        return true
    }
}
