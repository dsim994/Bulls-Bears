//
//  ShareStatsTableViewCell.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/21/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import UIKit

class ShareStatsTableViewCell: UITableViewCell {

    @IBOutlet weak var shareStatsKeyLabel: UILabel!
    
    @IBOutlet weak var shareStatsValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
