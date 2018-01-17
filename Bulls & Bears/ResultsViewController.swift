//
//  ResultsViewController.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 1/12/18.
//  Copyright © 2018 dylansimerly. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------------#VARIABLES-------------------------------------------*/

    var viewModel = Singleton.shared
    var companyNameDisplay = String()
    var symbolDisplay = String()
    var latestPriceDisplay = Double()
    var changeDisplay = Double()
    var changePercentDisplay = Double()
    var tableTitles = [
        "Previous Close", "Open", "Bid", "Ask", "Day's Range",
        "52 Week Range", "Volume",
        "Average Volume", "Market Cap", "PE Ratio"
    ]
    

/*-------------------------------------------------------------------------------------------------*\
\*---------------------------------------------#OUTLETS--------------------------------------------*/
    
    @IBOutlet weak var latestPriceLabel: UILabel!
    @IBOutlet weak var chartView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var changePercentLabel: UILabel!
    
/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------------#VIEWSETUP-------------------------------------------*/

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = "\(companyNameDisplay)"
        symbolLabel.text! = "(\(symbolDisplay))"
        convertQuotes()
//        makeStatsRequest()
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
//
//    func makeStatsRequest() {
//        let defaultUrl = "https://api.iextrading.com/1.0/stock/"
//        let statsRequest = "/stats"
//        let jsonUrl = ("\(defaultUrl)\(symbolDisplay)\(statsRequest)")
//        let url = URL(string: jsonUrl)
//
//        URLSession.shared.dataTask(with: url!) { (data, response, err) in
//            guard let data = data else { return }
//            do {
//                let fetchedStats = try JSONDecoder().decode(Stats.self, from: data)
//                self.viewModel.statsArray.append(fetchedStats)
//                print(self.viewModel.statsArray)
//            }catch {
//                print("Error")
//            }
//            }.resume()
//    }
}

/*-------------------------------------------------------------------------------------------------*\
\*----------------------------------------#CONVERTQUOESMETHODS-------------------------------------*/

extension ResultsViewController {
    
    func convertQuotes() {
        
        var percentIndicator = ""
        
        if changeDisplay > 0 {
            percentIndicator = "+"
            changeLabel.textColor = UIColor.green
        } else {
            changeLabel.textColor = UIColor.red
        }
        
        if changePercentDisplay > 0 {
            percentIndicator = "+"
            changePercentLabel.textColor = UIColor.green
        } else {
            changePercentLabel.textColor = UIColor.red
        }
        
        //Convert Latest Price
        let roundedPriceDisplay = String(format: "%.2f", latestPriceDisplay)
        latestPriceLabel.text! = roundedPriceDisplay
        
        //Convert Change in Price
        let roundedChangeDisplay = String(format: "%.2f", changeDisplay)
        changeLabel.text! = "(\(percentIndicator)\(roundedChangeDisplay))"
        
        //Convert Change Percent
        let roundedChangePercentDisplay = String(format: "%.2f", changePercentDisplay)
        changePercentLabel.text! = "(\(percentIndicator)\(roundedChangePercentDisplay)%)"
    }
}
/*-------------------------------------------------------------------------------------------------*\
\*------------------------------------------#TABLEVIEWMETHODS--------------------------------------*/

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = ("Key Data")
        return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        let roundedPreviousClose = String(format: "%.2f", self.viewModel.quoteArray[0].previousClose)
        let roundedOpen = String(format: "%.2f", self.viewModel.quoteArray[0].open)
        let roundedBid = String(format: "%.2f", self.viewModel.quoteArray[0].iexBidPrice)
        let roundedAsk = String(format: "%.2f", self.viewModel.quoteArray[0].iexAskPrice)
        let roundedHigh = String(format: "%.2f", self.viewModel.quoteArray[0].high)
        let roundedLow = String(format: "%.2f", self.viewModel.quoteArray[0].low)
        let roundedDayRange = ("\(roundedLow) - \(roundedHigh)")
        
//        let roundedClose = String(format: "%.2f", self.viewModel.quoteArray[0].close)
        let rounded52WeekHigh = String(format: "%.2f", self.viewModel.quoteArray[0].week52High)
        let rounded52WeekLow = String(format: "%.2f", self.viewModel.quoteArray[0].week52Low)
        let rounded52WeekRange = ("\(rounded52WeekLow) - \(rounded52WeekHigh)")
        
        let roundedVolume = String(format: "%.2fM", self.viewModel.quoteArray[0].latestVolume/1e6)
        let roundedAvgVolume = String(format: "%.2fM", self.viewModel.quoteArray[0].avgTotalVolume/1e6)
//        let roundedBeta = String(format: "%.2f", self.viewModel.statsArray[0].beta)
        let roundedMarketCap = String(format: "%.2fB", self.viewModel.quoteArray[0].marketCap/1e9)
        let roundedPERatio = String(format: "%.2f", self.viewModel.quoteArray[0].peRatio)

        let tableData = [roundedPreviousClose, roundedOpen, roundedBid, roundedAsk, roundedDayRange, rounded52WeekRange, roundedVolume, roundedAvgVolume, roundedMarketCap, roundedPERatio]

        cell.keyLabel.text = self.tableTitles[indexPath.row]
        cell.valueLabel.text = tableData[indexPath.row]
        return cell
    }
}











