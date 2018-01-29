//
//  MarketNewsCollectionViewCell.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/18/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import UIKit

class MarketNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        summaryLabel.textAlignment = NSTextAlignment.left
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//
//        self.contentView.autoresizingMask.insert(.flexibleHeight)
//        self.contentView.autoresizingMask.insert(.flexibleWidth)
    }
}
