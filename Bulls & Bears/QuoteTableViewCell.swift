//
//  QuoteTableViewCell.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "QuoteTableViewCell"
    static let expectedHeight: CGFloat = 60.0

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
}
