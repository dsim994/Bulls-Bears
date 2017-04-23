//
//  SearchViewModelData.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import Foundation

final class SearchViewModelData {
    
    enum Texts: String {
        case title = "Get A Quote"
        case placeholder = "Enter company name"
        
        case failDefaultTitle = "Sorry"
        case failMessage = "Fail to Search Symbol"
        case failDefaultMessage = "Not Found"
    }
}
