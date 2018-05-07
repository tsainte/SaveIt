//
//  OAuthAPI.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 05/05/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

protocol OAuth2 {
    func requestAuthenticationCode()
    func extractAuthenticationToken(from authURL: URL, completeHandler: @escaping (Token?) -> Void)
    func requestAccessToken(for authenticationToken: String, completeHandler: @escaping (Token?) -> Void)
}
