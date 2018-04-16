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
