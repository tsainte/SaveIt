//
//  AppDelegate.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var watchManager: WatchManager?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        print("Realm: \(DatabaseManager.filePath!)")

        watchManager = WatchManager()
        watchManager?.setupWatchConnectivity()

        return true
    }

    /// This method is called as a callback from another application, such as Safari
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        EmbedSafariManager.shared.dismiss()
        APIManager.shared.fetchMonzoToken(from: url)
        return true
    }
}
