//
//  SearchViewController.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/22/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
/*-------------------------------------------------------------------------------------------------*\
\*-------------------------------------------#VARIABLES--------------------------------------------*/
    
    var viewModel = Singleton.shared
    var enteredSymbol = ""
    var marketNewsArray = [[News]]()
    var collectionData = [News]()
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 350, height: 20))
    
/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------------#OUTLETS---------------------------------------------*/

    @IBOutlet weak var collectionView: UICollectionView!
    
/*-------------------------------------------------------------------------------------------------*\
\*-------------------------------------------#VIEWSETUP--------------------------------------------*/

    override func viewDidLoad() {
        super.viewDidLoad()
        makeNewsRequest()
        setSearchBar()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

/*-------------------------------------------------------------------------------------------------*\
\*-----------------------------------------#SEARCHBARMETHODS---------------------------------------*/

extension SearchViewController: UISearchBarDelegate {
    
    func setSearchBar() {
        
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.barStyle = UIBarStyle.blackTranslucent
        navigationItem.titleView = searchBar
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        hideKeyboardWhenTappedAround()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        enteredSymbol = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        makeBatchRequest()
  
    }
}

/*-------------------------------------------------------------------------------------------------*\
\*---------------------------------------#KEYBOARDMETHODS------------------------------------------*/

extension SearchViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

/*-------------------------------------------------------------------------------------------------*\
\*-------------------------------------#NETWORKREQUESTMETHODS--------------------------------------*/

extension SearchViewController {
    
    func makeNewsRequest() {
        let jsonUrl = "https://api.iextrading.com/1.0/stock/market/news/last/100"
        let url = URL(string: jsonUrl)
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            guard let data = data else { return }
            do {
                let fetchedNews = try JSONDecoder().decode([News].self, from: data)
                self.marketNewsArray.append(fetchedNews)
                self.collectionData = self.marketNewsArray[0]
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
    
    func makeBatchRequest() {
        let defaultUrl = "https://api.iextrading.com/1.0/stock/"
        let batchRequest = "/batch?types=quote,news,chart&range=3m&last=10"
        
        let jsonUrl = "\(defaultUrl)\(enteredSymbol)\(batchRequest)"
        let url = URL(string: jsonUrl)
        
        URLSession.shared.dataTask(with: url!) { (data, resoponse, err) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let fetchedBatch = try decoder.decode(Batch.self, from: data)
                self.viewModel.quoteArray.append(fetchedBatch.quote)
                self.viewModel.quoteNewsArray.append(fetchedBatch.news)
                self.viewModel.quoteChartArray.append(fetchedBatch.chart)
                
                DispatchQueue.main.async() {
                    self.performSegue(withIdentifier: "showResults", sender: self)
                }
            } catch {
                print("Error Parsing JSON")
            }
        }.resume()
    }

//    func makeStatsRequest() {
//        let defaultUrl = "https://api.iextrading.com/1.0/stock/"
//        let statsRequest = "/stats"
//        let jsonUrl = ("\(defaultUrl)\(enteredSymbol)\(statsRequest)")
//        let url = URL(string: jsonUrl)
//
//        URLSession.shared.dataTask(with: url!) { (data, response, err) in
//            guard let data = data else { return }
//            do {
//                let fetchedStats = try JSONDecoder().decode(Stats.self, from: data)
//                self.viewModel.statsArray.append(fetchedStats)
//                print(self.viewModel.statsArray)
//
//            }catch {
//                print("Error")
//            }
//        }.resume()
//    }
}

/*-------------------------------------------------------------------------------------------------*\
\*------------------------------------------#SEGUEMETHODS------------------------------------------*/

extension SearchViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destVC = segue.destination as? ResultsViewController
        destVC?.companyNameDisplay = self.viewModel.quoteArray[0].companyName
        destVC?.symbolDisplay = self.viewModel.quoteArray[0].symbol
        destVC?.latestPriceDisplay = self.viewModel.quoteArray[0].latestPrice
        destVC?.changeDisplay = self.viewModel.quoteArray[0].change
        destVC?.changePercentDisplay = self.viewModel.quoteArray[0].changePercent
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        self.contentView.layer.cornerRadius = 2.0
//        self.contentView.layer.borderWidth = 1.0
//        self.contentView.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.layer.masksToBounds = true
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        self.layer.shadowRadius = 2.0
//        self.layer.shadowOpacity = 1.0
//        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
//        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketNewsCell", for: indexPath) as! MarketNewsCollectionViewCell
        
        cell.headlineLabel.text = self.collectionData[indexPath.row].headline
        cell.summaryLabel.text = self.collectionData[indexPath.row].summary
        cell.dateLabel.text = self.collectionData[indexPath.row].datetime
        
        return cell
    }
    
    
}








