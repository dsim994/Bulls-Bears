//
//  TradeDataTableViewCell.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/21/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import UIKit

class TradeDataTableViewCell: UITableViewCell {

    @IBOutlet weak var tradeDataKeyLabel: UILabel!
    
    @IBOutlet weak var tradeDataValueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
