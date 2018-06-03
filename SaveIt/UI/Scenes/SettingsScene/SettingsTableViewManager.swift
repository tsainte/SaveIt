//
//  SettingsTableViewManager.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 03/06/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class SettingsTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    weak var viewModel: SettingsViewModel!
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.title(for: section)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}
