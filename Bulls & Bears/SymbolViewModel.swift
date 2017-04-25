//
//  SymbolViewModel.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import Foundation
import RxCocoa
import RxDataSources
import RxSwift
import ObjectMapper

protocol SymbolViewModel: YahooFinanceViewModel {
    
    func refreshUI()
    func showLoading()
    func hideLoading()
    func queryQuoteSuccess(quotes: [Quote])
    func queryQuoteFail(error: NSError?)
}

extension SymbolViewModel {
    
    var results:[Result] {
        get {
            return SymbolViewModelData.sharedData.results
        }
        set {
            SymbolViewModelData.sharedData.results = newValue
            self.refreshUI()
        }
    }
    
    func getTexts(_ key: SymbolViewModelData.Texts) -> String {
        return key.rawValue
    }
    
    func queryQuote(_ symbol:String) {
        self.showLoading()
        QueryParser.query([symbol]) { (quotes, error) in
            if (quotes != nil) {
                self.queryQuoteSuccess(quotes: quotes!)
            } else {
                self.queryQuoteFail(error: error)
            }
            self.hideLoading()
        }
    }
}


