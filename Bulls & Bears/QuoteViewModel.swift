//
//  QuoteViewModel.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

protocol QuoteViewModel: YahooFinanceViewModel {
    
    func refreshUI()
}

extension QuoteViewModel {
    
    var fixedIndex: Int {
        get { return 0 }
    }
    
    var quotes:[Quote] {
        get {
            return QuoteViewModelData.sharedData.quotes
        }
        set {
            QuoteViewModelData.sharedData.quotes = newValue
            self.refreshUI()
        }
    }
}

