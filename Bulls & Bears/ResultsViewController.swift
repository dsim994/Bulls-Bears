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
    var keyDataTableKeys = [
        "Previous Close", "Open", "Day's Range",
        "52 Week Range", "Volume",
        "Average Volume", "Market Cap", "PE Ratio"
    ]
    var collectionViewData = [News]()
    
    
    
    
    
    

/*-------------------------------------------------------------------------------------------------*\
\*---------------------------------------------#OUTLETS--------------------------------------------*/
    
    
    
    
    
    
    @IBOutlet weak var latestPriceLabel: UILabel!
    @IBOutlet weak var chartView: UIImageView!
    @IBOutlet weak var keyDataTableView: UITableView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var changePercentLabel: UILabel!
    @IBOutlet weak var showStatsButton: UIButton!
    @IBOutlet weak var showNewsButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    
/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------------#VIEWSETUP-------------------------------------------*/
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    
    
    
    
    
    
    @IBAction func showStatsPressed(_ sender: Any) {
        makeStatsRequest()
    }
    
    
    @IBAction func showNewsPressed(_ sender: Any) {

    }
}







extension ResultsViewController {
    func setView() {
        
        
        self.navigationItem.title = "\(companyNameDisplay)"
        symbolLabel.text! = "(\(symbolDisplay))"
        convertQuotes()
        keyDataTableView.delegate = self
        keyDataTableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionViewData = self.viewModel.quoteNewsArray[0]
        
        
        DispatchQueue.main.async{
            self.keyDataTableView.reloadData()
        }
        
        
    }
}










/*-------------------------------------------------------------------------------------------------*\
\*---------------------------------------#CONVERTQUOTESMETHODS-------------------------------------*/







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
\*------------------------------------------#NETWORKMETHODS----------------------------------------*/




extension ResultsViewController {
    
    
    func makeStatsRequest() {
        let defaultUrl = "https://api.iextrading.com/1.0/stock/"
        let statsRequest = "/stats"
        let jsonUrl = ("\(defaultUrl)\(symbolDisplay)\(statsRequest)")
        let url = URL(string: jsonUrl)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            guard let data = data else { return }
            do {
                print(data)
                let fetchedStats = try JSONDecoder().decode(Stats.self, from: data)
                print(fetchedStats)
                self.viewModel.statsArray.append(fetchedStats)
                //                print(self.viewModel.statsArray)
                
                DispatchQueue.main.async() {
                    self.performSegue(withIdentifier: "showStats", sender: self)
                }
            }catch {
                print("Error")
            }
        }.resume()
    }
}



/*-------------------------------------------------------------------------------------------------*\
\*------------------------------------------#TABLEVIEWMETHODS--------------------------------------*/





extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyDataTableKeys.count
    }
    
    
    
    
    
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        

        let cell = keyDataTableView.dequeueReusableCell(withIdentifier: "keyDataTableViewCell", for: indexPath) as! KeyDataTableViewCell
        
        
        

        let roundedPreviousClose = String(format: "%.2f", self.viewModel.quoteArray[0].previousClose)
        let roundedOpen = String(format: "%.2f", self.viewModel.quoteArray[0].open)
//        let roundedBid = String(format: "%.2f", (self.viewModel.quoteArray[0].iexBidPrice)
//        let roundedAsk = String(format: "%.2f", self.viewModel.quoteArray[0].iexAskPrice)
        let roundedHigh = String(format: "%.2f", self.viewModel.quoteArray[0].high)
        let roundedLow = String(format: "%.2f", self.viewModel.quoteArray[0].low)
        let roundedDayRange = ("\(roundedLow) - \(roundedHigh)")
        
        let rounded52WeekHigh = String(format: "%.2f", self.viewModel.quoteArray[0].week52High)
        let rounded52WeekLow = String(format: "%.2f", self.viewModel.quoteArray[0].week52Low)
        let rounded52WeekRange = ("\(rounded52WeekLow) - \(rounded52WeekHigh)")
        
        let roundedVolume = String(format: "%.2fM", self.viewModel.quoteArray[0].latestVolume/1e6)
        let roundedAvgVolume = String(format: "%.2fM", self.viewModel.quoteArray[0].avgTotalVolume/1e6)
        let roundedMarketCap = String(format: "%.2fB", self.viewModel.quoteArray[0].marketCap/1e9)
        let roundedPERatio = String(format: "%.2f", self.viewModel.quoteArray[0].peRatio)
        
        
        
        
        

        let keyDataTableData = [roundedPreviousClose, roundedOpen, roundedDayRange, rounded52WeekRange, roundedVolume, roundedAvgVolume, roundedMarketCap, roundedPERatio]
        
        
        
        
        

        cell.keyDataKeyLabel.text = self.keyDataTableKeys[indexPath.row]
        cell.keyDataValueLabel.text = keyDataTableData[indexPath.row]
        return cell
    }
}








/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------COLLECTIONVIEWMETHODS--------------------------------------*/









extension ResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        
        
        return self.collectionViewData.count
        
        
        
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "symbolNewsCell", for: indexPath) as! SymbolNewsCollectionViewCell

        
        
        
        
        cell.headlineLabel.text = self.collectionViewData[indexPath.row].headline
        cell.dateLabel.text = self.collectionViewData[indexPath.row].datetime
        return cell
    }
}


















