//
//  SettingsViewModel.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 07/05/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class SettingsViewModel: NSObject {

    struct Sections {
        static let environment = 0
    }
    var numberOfSections: Int {
        return 1
    }

}

extension SettingsViewModel {

    func numberOfRows(section: Int) -> Int {
        return 1
    }

    func cellData(indexPath: IndexPath) -> [String: String] {
        switch indexPath.section {
        case Sections.environment:
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
}
