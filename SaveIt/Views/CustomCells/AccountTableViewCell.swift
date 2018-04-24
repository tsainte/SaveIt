//
//  AccountTableViewCell.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 28/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var sortCodeTitle: UILabel!
    @IBOutlet weak var accountNumberTitle: UILabel!
    @IBOutlet weak var sortCodeValue: UILabel!
    @IBOutlet weak var accountNumberValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
