//
//  TableViewCell.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/13/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let reuseIdentifier = "TableViewCell"

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
