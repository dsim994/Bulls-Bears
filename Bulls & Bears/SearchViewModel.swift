//
//  SearchViewModel.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import RxCocoa

protocol SearchViewModel {
    
    func showLoading()
    func hideLoading()
    func searchSuccess(results: [Result])
    func searchFail(error: NSError?)
}

extension SearchViewModel {
    
    func getTexts(_ key: SearchViewModelData.Texts) -> String {
        return key.rawValue
    }
    
    func searchStart(inputString: String) {
        self.showLoading()
        
        SearchParser.getSymbols(inputString) { (searchResults, error) in
            if (searchResults != nil) {
                if (searchResults!.count != 0) {
                    self.searchSuccess(results: searchResults!)
                } else {
                    self.searchFail(error: error)
                }
            } else {
                self.searchFail(error: error)
            }
            self.hideLoading()
        }
    }
}
