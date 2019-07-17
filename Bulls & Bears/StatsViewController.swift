//
//  StatsViewController.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/20/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    
    
    
    
/*-------------------------------------------------------------------------------------------------*\
\*-------------------------------------------#VARIABLES--------------------------------------------*/
    
    
    
    
    
    
    var viewModel = Singleton.shared
    
    
    
    var statsTableData = [String]()
    
    var statsTableKeys = [
        "Previous Close", "Open", "Low", "High", "52 Week Low", "52 Week High",
        "Volume", "Average Volume", "Market Cap", "PE Ratio"
    ]
    
    var dividendTableKeys = [
        "Dividend Rate", "Dividend Yield", "Dividend Date"
    ]
    
    var tradeDataTableKeys = [
        "Beta", "PE Ratio Low", "PE Ratio High", "52 Week Change",
        "50-Day Moving Average", "200-Day Moving Average"
    ]
    
    var shareStatsTableKeys = [
        "Float", "EPS", "Shares Outstanding", "Institutional Percent",
        "Short Ratio", "Short Interest", "Short Date"
    ]
    
    var financialsTableKeys = [
        "Price To Sales", "Price To Book", "Cash", "Debt", "Gross Profit",
        "Profit Margin", "Return On Assets", "Return On Equity", "EBITDA",
        "revenue", "revenuePerShare", "revenuePerEmployee"
    ]
    
    
    
    
    
    
/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------------#OUTLETS---------------------------------------------*/
    

    @IBOutlet weak var latestPriceLabel: UILabel!
    @IBOutlet weak var bidLabel: UILabel!
    @IBOutlet weak var askLabel: UILabel!
    @IBOutlet weak var statsTableView: UITableView!
    @IBOutlet weak var dividendTableView: UITableView!
    @IBOutlet weak var tradeDataTableView: UITableView!
    @IBOutlet weak var shareStatsTableView: UITableView!
    @IBOutlet weak var financialsTableView: UITableView!
  
    
    
    
    

    
    
    
    
    
/*-------------------------------------------------------------------------------------------------*\
\*-------------------------------------------#VIEWSETUP--------------------------------------------*/
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
}



extension StatsViewController {
    
    func setView() {
        
        statsTableView.delegate = self
        statsTableView.dataSource = self

        dividendTableView.delegate = self
        dividendTableView.dataSource = self
        
        tradeDataTableView.delegate = self
        tradeDataTableView.dataSource = self
        
        shareStatsTableView.delegate = self
        shareStatsTableView.dataSource = self
        
        financialsTableView.delegate = self
        financialsTableView.dataSource = self

        DispatchQueue.main.async{
            self.statsTableView.reloadData()
            self.dividendTableView.reloadData()
            self.tradeDataTableView.reloadData()
            self.shareStatsTableView.reloadData()
            self.financialsTableView.reloadData()
        }
        
        let roundedLatestPrice = String(format: "%.2f", self.viewModel.quoteArray[0].latestPrice!)
        latestPriceLabel.text = roundedLatestPrice
        
        if let roundedBid = (self.viewModel.quoteArray[0].iexBidPrice) {
             bidLabel.text = ("Bid: \(roundedBid)")
        }else {
            print("Bid is null")
        }
        if let roundedAsk = (self.viewModel.quoteArray[0].iexAskPrice){
            askLabel.text = ("Ask: \(roundedAsk)")
        } else {
            print("Ask is null")
        } 
        
    }
}









/*-------------------------------------------------------------------------------------------------*\
\*------------------------------------------#TABLEVIEWMETHODS--------------------------------------*/




//extension Date {
//
//    func asString(style: DateFormatter.Style) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = style
//        return dateFormatter.string(from: self)
//    }
//}


//extension Double
//{
//    var cleanValue: String
//    {
//        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
//    }
//}



extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
    
        
        if tableView == statsTableView {
            return statsTableKeys.count
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
        if let previousClose = self.viewModel.quoteArray[0].previousClose {
            let roundedPreviousClose = String(format: "%.2f", previousClose)
            self.statsTableData.append(roundedPreviousClose)
        } else {
            print("Previous Close Is Null")
        }
        
        
        if let open = self.viewModel.quoteArray[0].open {
            let roundedOpen = String(format: "%.2f", open)
            self.statsTableData.append(roundedOpen)
        } else {
            print("Open Is Null")
        }
    

        if let low = self.viewModel.quoteArray[0].low {
            let roundedLow = String(format: "%.2f", low)
            self.statsTableData.append(roundedLow)
        } else {
            print("Low Is Null")
        }
        
        if let high = self.viewModel.quoteArray[0].high {
            let roundedHigh = String(format: "%.2f", high)
            self.statsTableData.append(roundedHigh)
        } else {
            print("High Is Null")
        }
        
        if let week52Low = self.viewModel.quoteArray[0].week52Low {
            let roundedWeek52Low = String(format: "%.2f", week52Low)
            self.statsTableData.append(roundedWeek52Low)
        } else {
            print("Week 52 Low Is Null")
        }
        
        if let week52High = self.viewModel.quoteArray[0].week52High {
            let roundedWeek52High =  String(format: "%.2f", week52High)
            self.statsTableData.append(roundedWeek52High)
        } else {
            print("Week 52 High Is Null")
        }
        
        
        if let volume = self.viewModel.quoteArray[0].latestVolume {
            let roundedVolume = String(format: "%.2fM", volume/1e6)
            self.statsTableData.append(roundedVolume)
        } else {
            print("Volume Is Null")
        }
        
        if let avgVolume = self.viewModel.quoteArray[0].avgTotalVolume {
            let roundedAvgVolume = String(format: "%.2fM", avgVolume/1e6)
            self.statsTableData.append(roundedAvgVolume)
        } else {
            print("Average Volume Is Null")
        }
        
        
        if let marketCap = self.viewModel.quoteArray[0].marketCap {
            let roundedMarketCap = String(format: "%.2fB", marketCap/1e9)
            self.statsTableData.append(roundedMarketCap)
        } else {
            print("Market Cap Is Null")
        }
    
        
        if let peRatio = self.viewModel.quoteArray[0].peRatio {
            let roundedPERatio = String(format: "%.2f", peRatio)
            self.statsTableData.append(roundedPERatio)
        } else {
            print("PE Ratio Is Null")
        }
    
        
        

        
    
        //Dividend Table View
        let roundedDividendYeild = String(format: "%.2f", self.viewModel.statsArray[0].dividendYield)
        let roundedDividendRate = String(format: "%.2f", self.viewModel.statsArray[0].dividendRate)
        let dividendDate = ("\(self.viewModel.statsArray[0].exDividendDate)")

        let dividendTableData = [
            roundedDividendRate, "\(roundedDividendYeild)%", dividendDate
            ]
        
        
        
        
        
        
        
        
        
        //Trade Data Table View
        let roundedBeta = String(format: "%.2f", self.viewModel.statsArray[0].beta)
        let roundedPERatioLow = String(format: "%.2f", self.viewModel.statsArray[0].peRatioLow)
        let roundedPERatioHigh = String(format: "%.2f", self.viewModel.statsArray[0].peRatioHigh)
        let rounded52WeekChange = String(format: "%.2f", self.viewModel.statsArray[0].week52change)
        let roundedDay50MovingAvg = String(format: "%.2f", self.viewModel.statsArray[0].day50MovingAvg)
        let roundedDay200MovingAvg = String(format: "%.2f", self.viewModel.statsArray[0].day200MovingAvg)

        let tradeDataTableData = [
            roundedBeta, roundedPERatioLow, roundedPERatioHigh, "\(rounded52WeekChange)%",
            roundedDay50MovingAvg, roundedDay200MovingAvg
        ]
        
        
        
        
        
        
        
        
        //Share Stats Table View
        let roundedFloat = String(format: "%.2fB", self.viewModel.statsArray[0].float/1e9)
        let roundedEPS = String(format: "%.2f", self.viewModel.statsArray[0].latestEPS)
        let roundedSharesOutstanding = String(format: "%.2fB", self.viewModel.statsArray[0].sharesOutstanding/1e9)
        let roundedInstitutionalPercent = String(format: "%.2f", self.viewModel.statsArray[0].institutionPercent)
        let roundedShortRatio = String(format: "%.2f", self.viewModel.statsArray[0].shortRatio)
        let roundedShortInterest = String(format: "%.2fM", self.viewModel.statsArray[0].shortInterest/1e6)
        let roundedShortDate = self.viewModel.statsArray[0].shortDate
        
        let shareStatsTableData = [
             roundedFloat, roundedEPS, roundedSharesOutstanding, "\(roundedInstitutionalPercent)%",
             "\(roundedShortRatio)%", roundedShortInterest, roundedShortDate
        ]
        
        
        
        
        
        
        
        //Financials Table View
        let priceToSales = String(format: "%.2f", self.viewModel.statsArray[0].priceToSales)
        let priceToBook = String(format: "%.2f", self.viewModel.statsArray[0].priceToBook)
        let cash = String(format: "%.2fB", self.viewModel.statsArray[0].cash/1e9)
        let debt = String(format: "%.2fB", self.viewModel.statsArray[0].debt/1e9)
        let grossProfit = String(format: "%.2fB", self.viewModel.statsArray[0].grossProfit/1e9)
        let profitMargin = String(format: "%.2f", self.viewModel.statsArray[0].profitMargin)
        let returnOnAssets =  String(format: "%.2f", self.viewModel.statsArray[0].returnOnAssets)
        let returnOnEquity = String(format: "%.2f", self.viewModel.statsArray[0].returnOnEquity)
        let EBITDA = String(format: "%.2fB", self.viewModel.statsArray[0].EBITDA/1e9)
        let revenue = String(format: "%.2fB", self.viewModel.statsArray[0].revenue/1e9)
        let revenuePerShare = String(format: "%.2f", self.viewModel.statsArray[0].revenuePerShare)
        let revenuePerEmployee = String(format: "%.2fM", self.viewModel.statsArray[0].revenuePerEmployee/1e6)

        let financialsTableData = [
            priceToSales, priceToBook, cash, debt, grossProfit,
            "\(profitMargin)%", "\(returnOnAssets)%", "\(returnOnEquity)%",
            EBITDA, revenue, revenuePerShare, revenuePerEmployee
        ]
        
        
        
        
        
        
        
        
        
        //Assinging Cells To Labels

        if tableView == statsTableView {
            let cell1 = statsTableView.dequeueReusableCell(withIdentifier: "statsTableViewCell", for: indexPath) as? StatsTableViewCell
            cell1?.statsKeyLabel.text = statsTableKeys[indexPath.row]
            cell1?.statsValueLabel.text = statsTableData[indexPath.row]
            return cell1!
        }
        
        
        
        
        else if tableView == dividendTableView {
            let cell2 = dividendTableView.dequeueReusableCell(withIdentifier: "dividendTableViewCell", for: indexPath) as? DividendTableViewCell
            cell2?.dividendKeyLabel.text = dividendTableKeys[indexPath.row]
            cell2?.dividendValueLabel.text = dividendTableData[indexPath.row]
            return cell2!
        }
        
        
        
        
        else if tableView == tradeDataTableView {
            let cell3 = tradeDataTableView.dequeueReusableCell(withIdentifier: "tradeDataTableViewCell", for: indexPath) as? TradeDataTableViewCell
            cell3?.tradeDataKeyLabel.text = tradeDataTableKeys[indexPath.row]
            cell3?.tradeDataValueLabel.text = tradeDataTableData[indexPath.row]
            return cell3!
        }
        
        
        
        else if tableView == shareStatsTableView {
            let cell4 = shareStatsTableView.dequeueReusableCell(withIdentifier: "shareStatsTableViewCell", for: indexPath) as? ShareStatsTableViewCell
            cell4?.shareStatsKeyLabel.text = shareStatsTableKeys[indexPath.row]
            cell4?.shareStatsValueLabel.text = shareStatsTableData[indexPath.row]
            return cell4!
        }
        
        
        
        else if tableView == financialsTableView {
            let cell5 = financialsTableView.dequeueReusableCell(withIdentifier: "financialsTableViewCell", for: indexPath) as? FinancialsTableViewCell
            cell5?.financialsKeyLabel.text = financialsTableKeys[indexPath.row]
            cell5?.financialsValueLabel.text = financialsTableData[indexPath.row]
            return cell5!
        }
        
        
        
        
        return UITableViewCell()
    }
}







    




