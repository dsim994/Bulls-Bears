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
    
    var keyDataTableKeys = [
        "Previous Close", "Open", "Day's Range", "52 week range",
        "Volume", "Average Volume", "EPS", "Market Cap"
    ]
    
    var dividendTableKeys = [
        "Dividend Yield", "Dividend Rate", "Dividend Date"
    ]
    
    var tradeDataTableKeys = [
        "Beta", "52 Week High", "52 Week Low", "50-Day Moving Average",
        "200-Day Moving Average", "ytd Change", "PERatio"
    ]
    
    var shareStatsTableKeys = [
        "Shares Outstanding", "Float", "Short Interest", "Short Ratio", "Short Date"
    ]
    
    var financialsTableKeys = [
        "Price To Sale", "Price To Book", "Return On Assets",
        "Profit Margin", "Revenue Per Share", "Revenue Per Employee",
        "Cash", "Debt", "Gross Profit", "EBITA", "Return On Equity"
    ]
    
    
    
    
    
    
    
    
    

    @IBOutlet weak var latestPriceLabel: UILabel!
    @IBOutlet weak var keyDataTableView: UITableView!
    @IBOutlet weak var dividendTableView: UITableView!
    @IBOutlet weak var tradeDataTableView: UITableView!
    @IBOutlet weak var shareStatsTableView: UITableView!
    @IBOutlet weak var financialsTableView: UITableView!
  
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
}







extension StatsViewController {
    
    func setView() {
        
        keyDataTableView.delegate = self
        keyDataTableView.dataSource = self

        dividendTableView.delegate = self
        dividendTableView.dataSource = self
        
        tradeDataTableView.delegate = self
        tradeDataTableView.dataSource = self
        
        shareStatsTableView.delegate = self
        shareStatsTableView.dataSource = self
        
        financialsTableView.delegate = self
        financialsTableView.dataSource = self

        DispatchQueue.main.async{
            self.keyDataTableView.reloadData()
            self.dividendTableView.reloadData()
            self.tradeDataTableView.reloadData()
            self.shareStatsTableView.reloadData()
            self.financialsTableView.reloadData()
        }
        
        let roundedLatestPrice = String(format: "%.2f", self.viewModel.quoteArray[0].latestPrice)
        latestPriceLabel.text = roundedLatestPrice
    }
}

//extension Formatter {
//    static let withSeparator: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.groupingSeparator = ","
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
//}








extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
    
        
        if tableView == keyDataTableView {
            return keyDataTableKeys.count
        } else if tableView == dividendTableView {
            return dividendTableKeys.count
        } else if tableView == tradeDataTableView {
            return tradeDataTableKeys.count
        } else if  tableView == shareStatsTableView {
            return shareStatsTableKeys.count
        } else if tableView == financialsTableView {
            return financialsTableKeys.count
        } else {
            return 0
        }
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        //Key Data Table View
        let roundedPreviousClose = String(format: "%.2f", self.viewModel.quoteArray[0].previousClose)
        let roundedOpen = String(format: "%.2f", self.viewModel.quoteArray[0].open)
        let roundedHigh = String(format: "%.2f", self.viewModel.quoteArray[0].high)
        let roundedLow = String(format: "%.2f", self.viewModel.quoteArray[0].low)
        let roundedDayRange = ("\(roundedLow)-\(roundedHigh)")
        let rounded52WeekChange = String(format: "%.2f", self.viewModel.statsArray[0].week52change)
        let roundedVolume = String(format: "%.2fM", self.viewModel.quoteArray[0].latestVolume/1e6)
        let roundedAvgVolume = String(format: "%.2fM", self.viewModel.quoteArray[0].avgTotalVolume/1e6)
        let roundedEPS = String(format: "%.2f", self.viewModel.statsArray[0].latestEPS)
        let roundedMarketCap = String(format: "%.2fB", self.viewModel.quoteArray[0].marketCap/1e9)
        
        let keyDataTableData = [
            roundedPreviousClose, roundedOpen, roundedDayRange, rounded52WeekChange,
            roundedVolume, roundedAvgVolume, roundedEPS, roundedMarketCap
        ]
        
        
    
        //Dividend Table View
        let roundedDividendYeild = String(format: "%.2f", self.viewModel.statsArray[0].dividendYield)
        let roundedDividendRate = String(format: "%.2f", self.viewModel.statsArray[0].dividendRate)
        let dividendDate = "\(self.viewModel.statsArray[0].exDividendDate)"
        
        let dividendTableData = [
            roundedDividendYeild, roundedDividendRate, dividendDate
        ]
        
        
        
        //Trade Data Table View
        let roundedPERatio = String(format: "%.2f", self.viewModel.quoteArray[0].peRatio)
        let roundedBeta = String(format: "%.2f", self.viewModel.statsArray[0].beta)
        let roundedDay200MovingAvg = String(format: "%.2f", self.viewModel.statsArray[0].day200MovingAvg)
        let roundedDay50MovingAvg = String(format: "%.2f", self.viewModel.statsArray[0].day50MovingAvg)
        let roundedYtdChangePercent = String(format: "%.2f", self.viewModel.statsArray[0].ytdChangePercent)
        let roundedWeek52High = String(format: "%.2f", self.viewModel.quoteArray[0].week52High)
        let roundedWeek52Low = String(format: "%.2f", self.viewModel.quoteArray[0].week52Low)
        
        let tradeDataTableData = [
            roundedBeta, roundedWeek52High, roundedWeek52Low, roundedDay50MovingAvg, roundedDay200MovingAvg, roundedYtdChangePercent, roundedPERatio
        ]
        
        
        
        //Share Stats Table View
        let roundedSharesOutstanding = String(format: "%.2fB", self.viewModel.statsArray[0].sharesOutstanding/1e9)
        let roundedFloat = String(format: "%.2fB", self.viewModel.statsArray[0].float/1e9)
        let roundedShortInterest = String(format: "%.2fB", self.viewModel.statsArray[0].shortInterest/1e9)
        let roundedShortDate = String(format: "%.2f", self.viewModel.statsArray[0].shortDate)
        let roundedShortRatio = String(format: "%.2f", self.viewModel.statsArray[0].shortRatio)
        
        let shareStatsTableData = [
            roundedSharesOutstanding, roundedFloat, roundedShortInterest,
            roundedShortRatio, roundedShortDate
        ]
        
        
        
        //Financials Table View
        let priceToSales = String(format: "%.2f", self.viewModel.statsArray[0].priceToSales)
        let priceToBook = String(format: "%.2f", self.viewModel.statsArray[0].priceToBook)
        let returnOnAssets =  String(format: "%.2f", self.viewModel.statsArray[0].returnOnAssets)
        let profitMargin = String(format: "%.2f", self.viewModel.statsArray[0].profitMargin)
        let revenuePerShare = String(format: "%.2f", self.viewModel.statsArray[0].revenuePerShare)
        let revenuePerEmployee = String(format: "%.2f", self.viewModel.statsArray[0].revenuePerEmployee)
        let returnOnEquity = String(format: "%.2f", self.viewModel.statsArray[0].returnOnEquity)
        let EBITDA = String(format: "%.2f", self.viewModel.statsArray[0].EBITDA)
        //    let revenu: Int
        let grossProfit = String(format: "%.2f", self.viewModel.statsArray[0].grossProfit)
        let cash = String(format: "%.2f", self.viewModel.statsArray[0].cash)
        let debt = String(format: "%.2f", self.viewModel.statsArray[0].debt)

        let financialsTableData = [
            priceToSales, priceToBook, returnOnAssets, profitMargin, revenuePerShare,
            revenuePerEmployee, cash, debt, grossProfit, EBITDA, returnOnEquity
        ]
        
        
        
        
        //Assinging Cells To Labels
        if tableView == keyDataTableView {
            let cell1 = keyDataTableView.dequeueReusableCell(withIdentifier: "keyDataTableViewCell", for: indexPath) as? StatsTableViewCell
            cell1?.keyDataKeyLabel.text = keyDataTableKeys[indexPath.row]
            cell1?.keyDataValueLabel.text = keyDataTableData[indexPath.row]
            return cell1!
        } else if tableView == dividendTableView {
            let cell2 = dividendTableView.dequeueReusableCell(withIdentifier: "dividendTableViewCell", for: indexPath) as? DividendTableViewCell
            cell2?.dividendKeyLabel.text = dividendTableKeys[indexPath.row]
            cell2?.dividendValueLabel.text = dividendTableData[indexPath.row]
            return cell2!
        } else if tableView == tradeDataTableView {
            let cell3 = tradeDataTableView.dequeueReusableCell(withIdentifier: "tradeDataTableViewCell", for: indexPath) as? TradeDataTableViewCell
            cell3?.tradeDataKeyLabel.text = tradeDataTableKeys[indexPath.row]
            cell3?.tradeDataValueLabel.text = tradeDataTableData[indexPath.row]
            return cell3!
        } else if tableView == shareStatsTableView {
            let cell4 = shareStatsTableView.dequeueReusableCell(withIdentifier: "shareStatsTableViewCell", for: indexPath) as? ShareStatsTableViewCell
            cell4?.shareStatsKeyLabel.text = shareStatsTableKeys[indexPath.row]
            cell4?.shareStatsValueLabel.text = shareStatsTableData[indexPath.row]
            return cell4!
        } else if tableView == financialsTableView {
            let cell5 = financialsTableView.dequeueReusableCell(withIdentifier: "financialsTableViewCell", for: indexPath) as? FinancialsTableViewCell
            cell5?.financialsKeyLabel.text = financialsTableKeys[indexPath.row]
            cell5?.financialsValueLabel.text = financialsTableData[indexPath.row]
            return cell5!
        }
        return UITableViewCell()
    }
}







    




