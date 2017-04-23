//
//  SymbolTableViewCell.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import UIKit

class SymbolTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SymbolTableViewCell"
    static let expectedHeight: CGFloat = 60.0
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!

}
