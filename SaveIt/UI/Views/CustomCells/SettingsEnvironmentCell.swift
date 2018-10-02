//
//  SettingsEnvironmentCell.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 07/05/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class SettingsEnvironmentCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var environmentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension SettingsEnvironmentCell: CustomisableCell {

    func configureCell(with data: [String: String]) {
        iconImage.image = UIImage(named: data["icon"] ?? "")
        bankLabel.text = data["bank"]
        environmentLabel.text = data["environment"]
    }
}
