//
//  Banks.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 01/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import RealmSwift

class Bank: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var icon: String = ""

    static let monzo = Bank(name: "Monzo", icon: "icon_monzo")
    static let starling = Bank(name: "Starling", icon: "icon_starling")
    static let revolut = Bank(name: "Revolut", icon: "icon_revolut")
    static let hsbc = Bank(name: "HSBC", icon: "icon_hsbc")
    static let lloyds = Bank(name: "Lloyds Banking", icon: "icon_lloyds")

    convenience init(name: String, icon: String) {
        self.init()
        self.name = name
        self.icon = icon
    }
}
