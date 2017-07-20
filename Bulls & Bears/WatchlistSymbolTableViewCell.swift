//
//  WatchlistSymbolTableViewCell.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 7/14/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import UIKit

class WatchlistSymbolTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "WatchlistSymbolTableViewCell"
    static let expectedHeight: CGFloat = 60.0
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    

}
