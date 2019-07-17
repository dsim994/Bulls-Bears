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
        "Previous Close", "Open", "Low", "High",
        "52 Week Low", "52 Week High", "Volume",
        "Average Volume", "Market Cap", "PE Ratio"
    ]
    var collectionViewData = [News]()
    var keyDataTableData = [String]()
//    var messagesData = [Messages]()
    
    
    
    
    
    

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
    @IBOutlet weak var newsCollectionView: UICollectionView!
//    @IBOutlet weak var stockTwitsCollectionView: UICollectionView!
    
    
    
    
    
    
    
/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------------#VIEWSETUP-------------------------------------------*/
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        makeStockTwitsRequest()
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
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
//        stockTwitsCollectionView.delegate = self
//        stockTwitsCollectionView.dataSource = self
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
    
    
    
    

    
//
//    func makeStockTwitsRequest() {
//
//        let jsonUrl = "https://api.stocktwits.com/api/2/streams/symbol/AAPL.json"
//        let url = URL(string: jsonUrl)
//        URLSession.shared.dataTask(with: url!) { (data, response, err) in
//            guard let data = data else { return }
//            do {
//
//                let stockTwits = try JSONDecoder().decode(Root.self, from: data)
//                self.viewModel.messagesArray.append(stockTwits.messages)
//                self.messagesData = self.viewModel.messagesArray[0]
//                print(self.messagesData)
//
//                DispatchQueue.main.async {
//                    self.stockTwitsCollectionView.reloadData()
//                }
//
//            } catch {
//                print("Error")
//            }
//        }.resume()
//    }
    
    
    
    
    
    
    
    func makeStatsRequest() {
        
        let defaultUrl = "https://api.iextrading.com/1.0/stock/"
        let statsRequest = "/stats"
        let jsonUrl = ("\(defaultUrl)\(symbolDisplay)\(statsRequest)")
        let url = URL(string: jsonUrl)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            guard let data = data else { return }
            do {
                
                let fetchedStats = try JSONDecoder().decode(Stats.self, from: data)
                self.viewModel.statsArray.append(fetchedStats)
                
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
        
        
        
        
        if let previousClose = self.viewModel.quoteArray[0].previousClose {
            let roundedPreviousClose =  String(format: "%.2f", previousClose)
            self.keyDataTableData.append(roundedPreviousClose)
        } else {
            print("Previous Close Is Null")
        }
    
        
        if let open = self.viewModel.quoteArray[0].open {
            let roundedOpen = String(format: "%.2f", open)
            self.keyDataTableData.append(roundedOpen)
        } else {
            print("Open Is Null")
        }
    
        
        if let low = self.viewModel.quoteArray[0].low {
            let roundedLow = String(format: "%.2f", low)
            self.keyDataTableData.append(roundedLow)
        } else {
            print("Low is null")
        }
        
        if let high = self.viewModel.quoteArray[0].high{
            let roundedHigh = String(format: "%.2f", high)
            self.keyDataTableData.append(roundedHigh)
        } else {
            print("High is null")
        }
        
        if let week52Low = self.viewModel.quoteArray[0].week52Low {
            let roundedWeek52Low = String(format: "%.2f", week52Low)
            self.keyDataTableData.append(roundedWeek52Low)
        } else {
            print("Week 52 Low Is Null")
        }
        
        if let week52High = self.viewModel.quoteArray[0].week52High {
            let roundedWeek52High = String(format: "%.2f", week52High)
            self.keyDataTableData.append(roundedWeek52High)
        } else {
            print("Week 52 High Is Null")
        }
       
        if let volume = self.viewModel.quoteArray[0].latestVolume {
            let roundedVolume = String(format: "%.2fM", volume/1e6)
            self.keyDataTableData.append(roundedVolume)
        } else {
            print("Volume is null")
        }
        
        if let avgVolume = self.viewModel.quoteArray[0].avgTotalVolume {
            let roundedAvgVolume = String(format: "%.2fM", avgVolume/1e6)
            self.keyDataTableData.append(roundedAvgVolume)
        } else {
            print("Average Volume Is Null")
        }
    
        
        if let marketCap = self.viewModel.quoteArray[0].marketCap {
            let roundedMarketCap =  String(format: "%.2fB", marketCap/1e9)
            self.keyDataTableData.append(roundedMarketCap)
        } else {
            print("Market Cap Is Null")
        }
    
        
        if let peRatio = self.viewModel.quoteArray[0].peRatio {
            let roundedPERatio = String(format: "%.2f", peRatio)
            self.keyDataTableData.append(roundedPERatio)
        } else {
            print("PE Ratio Is Null")
        }
        
        

        
        
        cell.keyDataKeyLabel.text = self.keyDataTableKeys[indexPath.row]
        cell.keyDataValueLabel.text = keyDataTableData[indexPath.row]
        return cell
    }
}









/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------COLLECTIONVIEWMETHODS--------------------------------------*/









extension ResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    
        if collectionView == collectionView {
            return self.collectionViewData.count
//        } else if collectionView == stockTwitsCollectionView {
//            return self.messagesData.count
        } else {
            return 0
        }
        
        
        
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == newsCollectionView {
            let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "symbolNewsCell", for: indexPath) as! SymbolNewsCollectionViewCell
            
            cell.headlineLabel.text = self.collectionViewData[indexPath.row].headline
//            cell.dateLabel.text = self.collectionViewData[indexPath.row].datetime
            return cell
        } else {
            print("Error")
        }
//        } else if collectionView == stockTwitsCollectionView {
//            let cell = stockTwitsCollectionView.dequeueReusableCell(withReuseIdentifier: "stockTwitsCell", for: indexPath) as! StockTwitsCollectionViewCell
//
//            cell.messagesLabel.text = self.messagesData[indexPath.row].body
//            return cell
//        }
        
        return UICollectionViewCell()

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        return
    }
}


















