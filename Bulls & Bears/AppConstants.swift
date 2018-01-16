//
//  AppConstants.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/13/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import Foundation

struct Batch {
    let quotes = [Quote]()
    let news = [News]()
    let chart = [Chart]()
}

struct Quote: Decodable {
    let symbol: String
    let companyName: String
    let latestPrice: Double
    let change: Double
    let changePercent: Double
    let previousClose: Double
    let open: Double
    let close: Double
    let week52Low: Double
    let week52High: Double
    let latestVolume: Double
    let avgTotalVolume: Double
    let marketCap: Double
    let peRatio: Double
}

struct News: Decodable {
    let datetime: String
    let headline: String
    let source: String
    let url: String
    let summary: String
    let related: String
}
    
struct Chart {
    let minute: String
    let average: Double
    let notional: Double
    let numberOfTrades: Double
    let high: Double
    let low: Double
    let volume: Double
    let label: Double
    let changeOverTime: Double
    let date: String
    let open: Double
    let close: Double
    let unadjustedVolume: Double
    let change: Double
    let changePercent: Double
    let vwap: Double
}


