//
//  WatchManager.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 16/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import WatchConnectivity

class WatchManager: NSObject {

    func setupWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
}

// Send data to Apple Watch
extension WatchManager {

    // 1. Check if current device supports connectivity
    // 2. Check if the counterpart app is installed on Apple Watch
    // 3. If GG, send the dictionary by updating the application context
    static func sendContext(data: [String: Any]) {
        if WCSession.isSupported() {
            let session = WCSession.default
            if session.isWatchAppInstalled {
                do {
                    try session.updateApplicationContext(data)
                } catch {
                    print("Can't send context to Apple Watch - \(error.localizedDescription)")
                }
            }
        }
    }
}

extension WatchManager: WCSessionDelegate {

    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WC Session did become inative")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("WC Session did deactivate")
        WCSession.default.activate()
    }

    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {
        if let error = error {
            print ("WC Session activation failed with error: \(error.localizedDescription)")
            return
        }

        print("WC Session activated with state: \(activationState.rawValue)")
    }
}
