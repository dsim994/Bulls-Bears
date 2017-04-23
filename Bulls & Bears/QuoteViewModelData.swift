//
//  QuoteViewModelData.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import Foundation

final class QuoteViewModelData {
    static let sharedData = QuoteViewModelData()
    // In this sample case, the quotes has only one quote
    var quotes = [Quote]()
    
    enum Texts: String {
        case title = "Quote"
        
    }
}
