//
//  SettingsViewController.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    lazy var viewModel: SettingsViewModel = {
        return SettingsViewModel(delegate: self)
    }()

    lazy var tableViewManager: SettingsTableViewManager = {
        return SettingsTableViewManager(viewModel: viewModel)
    }()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = tableViewManager
            tableView.delegate = tableViewManager
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.removeEmptyCells()
    }
}

extension SettingsViewController: SettingsViewModelDelegate {
    func promptEnvironment() {
        print("prompt environment")
    }
}
