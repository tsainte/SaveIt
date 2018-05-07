//
//  SettingsViewController.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let viewModel = SettingsViewModel()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.removeEmptyCells()
    }
}

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsEnvironmentCell.identifier) as?
            SettingsEnvironmentCell else {
            return UITableViewCell()
        }

        let data = viewModel.cellData(indexPath: indexPath)
        cell.configureCell(with: data)

        return cell
    }
}
