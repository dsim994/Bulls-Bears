//
//  StatsViewController.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/20/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var viewModel = Singleton.shared
    var statsTableKeys = [
        "previous close", "open", "days range", "52 week range",
        "volume", "avgvolume", "marketcap:", "beta", "peratio",
        "eps", "dividend yield", "dividend date", "short interest",
        "short date", "shares outstanding", "float", "return on equity",
        "consensus eps", "numberOfEstimates", "symbol", "ebita",
        "gross profit", "cash", "debt", "ttmeps", "revenue per share",
        "revenue per employee", "eps surprise percent", "return on assets","profit margin",
        "price to sales", "price to book", "day 200 moving avg","day 50 moving avg",
        "institution percent", "short ratio", "year 5 change percent","year 2 change percent"
        , "year 1 change percent", "ytd change percent", "month 6 change percent",
        "month 3 change percent", "month 1 change percent", "day 5 change percent"
    ]

    @IBOutlet weak var statsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsTableView.delegate = self
        statsTableView.dataSource = self
        DispatchQueue.main.async{
            self.statsTableView.reloadData()
        }
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statsTableKeys.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "statsTableViewCell", for: indexPath) as! StatsTableViewCell
        
        let roundedPreviousClose = String(format: "%.2f", self.viewModel.quoteArray[0].previousClose)
        let roundedOpen = String(format: "%.2f", self.viewModel.quoteArray[0].open)
//
//        //        guard let roundedBid = String(format: "%.2f", (self.viewModel.quoteArray[0].iexBidPrice)!) else { return }
//
//
//        //        guard let roundedAsk = String(format: "%.2f", self.viewModel.quoteArray[0].iexAskPrice!) else { return }
//
        let roundedHigh = String(format: "%.2f", self.viewModel.quoteArray[0].high)
        let roundedLow = String(format: "%.2f", self.viewModel.quoteArray[0].low)
        let roundedDayRange = ("\(roundedLow) - \(roundedHigh)")

        let rounded52WeekChange = String(format: "%.2f", self.viewModel.statsArray[0].week52change)
        let roundedVolume = String(format: "%.2fM", self.viewModel.quoteArray[0].latestVolume/1e6)
        let roundedAvgVolume = String(format: "%.2fM", self.viewModel.quoteArray[0].avgTotalVolume/1e6)
        let roundedMarketCap = String(format: "%.2fB", self.viewModel.quoteArray[0].marketCap/1e9)
        let roundedBeta = String(format: "%.2f", self.viewModel.statsArray[0].beta)
        let roundedPERatio = String(format: "%.2f", self.viewModel.quoteArray[0].peRatio)
        let roundedEPS = String(format: "%.2f", self.viewModel.statsArray[0].latestEPS)
        
        let roundedDividendYeild = String(format: "%.2f", self.viewModel.statsArray[0].dividendYield)
        let roundedDividendRate = String(format: "%.2f", self.viewModel.statsArray[0].dividendRate)
        let roundedDividenedData = ("\(roundedDividendYeild)(\(roundedDividendRate)%)")
        let dividendDate = "\(self.viewModel.statsArray[0].exDividendDate)"
        
        let roundedShortInterest = String(format: "%.2fB", self.viewModel.statsArray[0].shortInterest)
        let roundedShortDate = String(format: "%.2f", self.viewModel.statsArray[0].shortDate)
        
        let roundedSharesOutstanding = String(format: "%.2fB", self.viewModel.statsArray[0].sharesOutstanding/1e9)
        let roundedFloat = String(format: "%.2fB", self.viewModel.statsArray[0].float/1e9)
        let returnOnEquity = String(format: "%.2f", self.viewModel.statsArray[0].returnOnEquity)
        let consensusEPS = String(format: "%.2f", self.viewModel.statsArray[0].consensusEPS)
        let numberOfEstimates = String(format: "%.2f", self.viewModel.statsArray[0].numberOfEstimates)
        let symbol =  String(format: "%.2f", self.viewModel.statsArray[0].symbol)
        let EBITDA = String(format: "%.2f", self.viewModel.statsArray[0].EBITDA)
        //    let revenu: Int
        let grossProfit = String(format: "%.2f", self.viewModel.statsArray[0].grossProfit)
        let cash = String(format: "%.2f", self.viewModel.statsArray[0].cash)
        let debt = String(format: "%.2f", self.viewModel.statsArray[0].debt)
        let ttmEPS = String(format: "%.2f", self.viewModel.statsArray[0].ttmEPS)
        let revenuePerShare = String(format: "%.2f", self.viewModel.statsArray[0].revenuePerShare)
        let revenuePerEmployee = String(format: "%.2f", self.viewModel.statsArray[0].revenuePerEmployee)
        let EPSSurprisePercent = String(format: "%.2f", self.viewModel.statsArray[0].EPSSurprisePercent)
        let returnOnAssets =  String(format: "%.2f", self.viewModel.statsArray[0].returnOnAssets)
        let profitMargin = String(format: "%.2f", self.viewModel.statsArray[0].profitMargin)
        let priceToSales = String(format: "%.2f", self.viewModel.statsArray[0].priceToSales)
        let priceToBook = String(format: "%.2f", self.viewModel.statsArray[0].priceToBook)
        let day200MovingAvg = String(format: "%.2f", self.viewModel.statsArray[0].day200MovingAvg)
        let day50MovingAvg = String(format: "%.2f", self.viewModel.statsArray[0].day50MovingAvg)
        let institutionPercent = String(format: "%.2f", self.viewModel.statsArray[0].institutionPercent)
        let shortRatio = String(format: "%.2f", self.viewModel.statsArray[0].shortRatio)
        let year5ChangePercent = String(format: "%.2f", self.viewModel.statsArray[0].year5ChangePercent)
        let year2ChangePercent = String(format: "%.2f", self.viewModel.statsArray[0].year2ChangePercent)
        let year1ChangePercent = String(format: "%.2f", self.viewModel.statsArray[0].year1ChangePercent)
        let ytdChangePercent = String(format: "%.2f", self.viewModel.statsArray[0].ytdChangePercent)
        let month6ChangePercent = String(format: "%.2f", self.viewModel.statsArray[0].month6ChangePercent)
        let month3ChangePercent = String(format: "%.2f", self.viewModel.statsArray[0].month3ChangePercent)
        let month1ChangePercent = String(format: "%.2f", self.viewModel.statsArray[0].month1ChangePercent)
        let day5ChangePercent =  String(format: "%.2f", self.viewModel.statsArray[0].day5ChangePercent)
        
        let statsTableData = [
            roundedPreviousClose, roundedOpen, roundedDayRange, rounded52WeekChange,
            roundedVolume, roundedAvgVolume, roundedMarketCap, roundedBeta,
            roundedPERatio, roundedEPS, roundedDividenedData, dividendDate,
            roundedShortInterest, roundedShortDate, roundedSharesOutstanding, roundedFloat,
            returnOnEquity, consensusEPS, numberOfEstimates, symbol, EBITDA,
            grossProfit, cash, debt, ttmEPS, revenuePerShare, revenuePerEmployee,
            EPSSurprisePercent, returnOnAssets, profitMargin, priceToSales,
            priceToBook, day200MovingAvg, day50MovingAvg, institutionPercent, shortRatio,
            year5ChangePercent, year2ChangePercent,year1ChangePercent, ytdChangePercent,
            month6ChangePercent, month3ChangePercent, month1ChangePercent, day5ChangePercent
        ]
        
        cell.keyLabel.text = statsTableKeys[indexPath.row]
        cell.valueLabel.text = statsTableData[indexPath.row]
        return cell
    }
}







    




