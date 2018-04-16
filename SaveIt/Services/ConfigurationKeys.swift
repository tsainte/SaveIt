//
//  ConfigurationKeys.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 27/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

class ConfigurationKeys {
    
    private let path: URL
    private let entries: [String: [String: String]]
    
    public static let shared = ConfigurationKeys()
    
    convenience init() {
        let path = Bundle.main.url(forResource: "configuration", withExtension: "plist")!
        self.init(with: path)
    }
    
    public init(with path: URL) {
        self.path = path
        self.entries = NSDictionary(contentsOf: path) as? [String: [String: String]] ?? [:]
    }
    
    public var monzoClientId: String {
        guard let monzo = entries["monzo"] else { return "" }
        return monzo["client_id"] ?? ""
    }

    public var monzoClientSecret: String {
        guard let monzo = entries["monzo"] else { return "" }
        return monzo["client_secret"] ?? ""
    }
    
    public var monzoRedirectLink: String {
        guard let monzo = entries["monzo"] else { return "" }
        return monzo["redirect_link"] ?? ""
    }
    
    public var starlingToken: String {
        guard let starling = entries["starling"] else { return "" }
        return starling["token"] ?? ""
    }
}
