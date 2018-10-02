//
//  UIViewController+Protocols.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 21/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

/// Defines a table view
@objc protocol Listable where Self: UIViewController {
    var tableView: UITableView! { get set }
}

/// Adds the behaviour of pull to refresh
@objc protocol Refreshable: Listable {
    var refreshControl: UIRefreshControl? { get set }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl)
}

extension Refreshable where Self: UIViewController {

    func setupRefreshControl(tintColor: UIColor = .black) {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = tintColor
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        self.refreshControl = refreshControl
    }
}
