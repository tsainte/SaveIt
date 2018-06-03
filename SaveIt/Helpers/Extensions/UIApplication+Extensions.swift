//
//  UIApplication+Extensions.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 05/05/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit
import SafariServices

extension UIApplication {

    func openEmbed(url: URL) {
        if let currentVC = self.delegate?.window??.rootViewController {
            EmbedSafariManager.shared.open(url: url, parentViewController: currentVC)
        }
    }
}
