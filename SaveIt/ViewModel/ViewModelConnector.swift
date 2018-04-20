//
//  ViewModelConnector.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 18/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import RealmSwift

protocol ViewModelConnector {
    var notificationToken: NotificationToken? { set get }
    func setupRealmObserver()
    func reloadData()
}
