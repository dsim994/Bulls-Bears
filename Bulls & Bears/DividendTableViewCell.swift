//
//  DividendTableViewCell.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/21/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import UIKit

class DividendTableViewCell: UITableViewCell {

    @IBOutlet weak var dividendKeyLabel: UILabel!
    
    @IBOutlet weak var dividendValueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
