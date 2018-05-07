//
//  CustomisableCell.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 07/05/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

protocol CustomisableCell where Self: UITableViewCell {
    static var identifier: String { get }
    func configureCell(with data: [String: String])
}

extension CustomisableCell {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
