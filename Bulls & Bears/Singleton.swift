//
//  Parser.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

final class Singleton {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    static let shared = Singleton()
    
    // MARK: Local Variable
    var quoteArray = [Quote]()
    var quoteNewsArray = [[News]]()
    var quoteChartArray = [[Chart]]()
    var statsArray = [Stats]()
    
}

