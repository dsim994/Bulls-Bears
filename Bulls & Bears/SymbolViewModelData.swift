//
//  SymbolViewModelData.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import Foundation

final class SymbolViewModelData {
    static let sharedData = SymbolViewModelData()
    
    var results = [Result]()
    
    enum Texts: String {
        case title = "Symbol"
        case failMessage = "Fail to Search Quote"
    }
}
