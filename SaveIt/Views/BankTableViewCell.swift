//
//  BankTableViewCell.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 01/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

protocol BankTableViewCellDelegate {
    func statusSwitchDidChange(cell: BankTableViewCell, to: Bool)
}

class BankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var status: UISwitch!
    
    var delegate: BankTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func statusDidChange(_ sender: UISwitch) {
        let statusValue = sender.isOn
        delegate?.statusSwitchDidChange(cell: self, to: statusValue)
    }
}
