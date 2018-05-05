//
//  EmbedSafariManager.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 05/05/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit
import SafariServices

class EmbedSafariManager: NSObject {

    static var shared = EmbedSafariManager()
    var safariViewController: SFSafariViewController?

    private override init() { }
}

// MARK: - Basic functions
extension EmbedSafariManager {

    func open(url: URL, delegate: SFSafariViewControllerDelegate? = nil, parentViewController: UIViewController) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.delegate = delegate
        parentViewController.present(safariViewController, animated: true)

        self.safariViewController = safariViewController
    }

    func dismiss(completionHandler: (() -> Void)? = nil) {
        safariViewController?.dismiss(animated: true, completion: completionHandler)
        safariViewController = nil
    }
}
