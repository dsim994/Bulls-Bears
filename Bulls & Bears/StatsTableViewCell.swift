//
//  StatsTableViewCell.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/20/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var keyDataKeyLabel: UILabel!
    @IBOutlet weak var keyDataValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
