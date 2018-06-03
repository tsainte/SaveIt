//
//  SettingsViewModel.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 07/05/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

protocol SettingsViewModelDelegate: class {
    func promptEnvironment()
}

class SettingsViewModel: NSObject {

    enum TableSection: Int {
        case environment = 0
        case theme
        case count // last one as helper to count sections
    }

    let titles = ["Environment", "Theme"]
    var numberOfSections: Int {
        return TableSection.count.rawValue
    }

    weak var delegate: SettingsViewModelDelegate?
    init(delegate: SettingsViewModelDelegate) {
        self.delegate = delegate
    }

}

// MARK: Table view bindings
extension SettingsViewModel {

    func numberOfRows(section: Int) -> Int {
        return 1
    }

    func cellData(indexPath: IndexPath) -> [String: String] {
        guard let tableSection = TableSection(rawValue: indexPath.section) else { return [:] }
        switch tableSection {
        case .environment:
            return environmentCellData(row: indexPath.row)
        default:
            return [:]
        }
    }

    func environmentCellData(row: Int) -> [String: String] {
        return ["icon": "icon_starling",
                "bank": "Starling Bank",
                "environment": "Sandbox"]
    }

    func title(for section: Int) -> String {
        return titles[section]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        switch section {
        case .environment:
            environment(selected: indexPath.row)
        default:
            return
        }
    }
}

extension SettingsViewModel {
    func environment(selected: Int) {
        delegate?.promptEnvironment()
    }
}
