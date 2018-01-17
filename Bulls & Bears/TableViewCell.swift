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
}
