//
//  AppConstants.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/13/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import Foundation








struct Batch: Decodable {
    let quote: Quote
    let news: [News]
    let chart: [Chart]
}

struct Quote: Decodable {
    let symbol: String?
    let companyName: String?
    let latestPrice: Double?
    let change: Double?
    let changePercent: Double?
    let previousClose: Double?
    let open: Double?
    let iexBidPrice: Double?
    let iexAskPrice: Double?
    let high: Double?
    let low: Double?
    let close: Double?
    let week52Low: Double?
    let week52High: Double?
    let latestVolume: Double?
    let avgTotalVolume: Double?
    let marketCap: Double?
    let peRatio: Double?
}

struct News: Decodable {
    let datetime: Double
    let headline: String
    let source: String
    let url: String
    let summary: String
    let related: String
    let image: String
}

struct Chart: Decodable {
    let date: String
    let open: Double
    let close: Double
    let high: Double
    let low: Double
    let volume: Double
    let uOpen: Double
    let uClose: Double
    let uHigh: Double
    let uLow: Double
    let uVolume: Double
    let change: Double
    let changePercent: Double
    let label: String
    let changeOverTime: Double
}









//struct Root: Decodable {
//    let messages: [Messages]
//    
//}
//struct Messages: Decodable {
//    let id: Int
//    let body: String
//    let created_at: String
//    let user: User
//}
//
//struct User: Decodable {
//    let username: String
//}
//
//











struct Stats: Decodable {
    
    let companyName: String
    let beta: Double
    let week52change: Double
    let dividendRate: Double
    let dividendYield: Double
    let exDividendDate: String
    let latestEPS: Double
    let shortInterest: Double
    let shortDate: String
    let sharesOutstanding: Double
    let float: Float
    let returnOnEquity: Double
    let consensusEPS: Double
    let numberOfEstimates: Int
    let symbol: String
    let EBITDA: Double
    let peRatioLow: Double
    let peRatioHigh: Double
    let revenue: Double
    let grossProfit: Double
    let cash: Double
    let debt: Double
    let ttmEPS: Double
    let revenuePerShare: Double
    let revenuePerEmployee: Double
    let EPSSurprisePercent: Double
    let returnOnAssets: Double
    let profitMargin: Double
    let priceToSales: Double
    let priceToBook: Double
    let day200MovingAvg: Double
    let day50MovingAvg: Double
    let institutionPercent: Double
    let shortRatio: Double
//    let year5ChangePercent: Double
//    let year2ChangePercent: Double
//    let year1ChangePercent: Double
//    let ytdChangePercent: Double
//    let month6ChangePercent: Double
//    let month3ChangePercent: Double
//    let month1ChangePercent: Double
//    let day5ChangePercent: Double
}














