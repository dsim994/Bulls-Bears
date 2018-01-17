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
    
/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------------#OUTLETS---------------------------------------------*/
    
    @IBOutlet weak var searchBar: UISearchBar!
    
/*-------------------------------------------------------------------------------------------------*\
\*-------------------------------------------#VIEWSETUP--------------------------------------------*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setSearchBar()
    }
}

/*-------------------------------------------------------------------------------------------------*\
\*-----------------------------------------#SEARCHBARMETHODS---------------------------------------*/

extension SearchViewController: UISearchBarDelegate {
    
    //Set The Delegate, Change Text Color & Enable High KeyBoad
    func setSearchBar() {
        searchBar.delegate = self
        hideKeyboardWhenTappedAround()
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
    }
    
    //Attach User Entered Text To Variable To Build URL
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        enteredSymbol = searchText
    }
    
    //Make The Request From Search Clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        makeBatchRequest()
  
    }
}

/*-------------------------------------------------------------------------------------------------*\
\*---------------------------------------#KEYBOARDMETHODS------------------------------------------*/

extension SearchViewController {
    
    //Method That Hides The Keyboard When Screen Is Touched
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
    

    
    //Network Request Method
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
                self.viewModel.newsArray.append(fetchedBatch.news)
                self.viewModel.chartArray.append(fetchedBatch.chart)
//                print(self.viewModel.quoteArray)
//                print(self.viewModel.newsArray)
//                print(self.viewModel.chartArray)
                
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

    //Segue Method Attaches Returned Quotes To Variables
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destVC = segue.destination as? ResultsViewController
        destVC?.companyNameDisplay = self.viewModel.quoteArray[0].companyName
        destVC?.symbolDisplay = self.viewModel.quoteArray[0].symbol
        destVC?.latestPriceDisplay = self.viewModel.quoteArray[0].latestPrice
        destVC?.changeDisplay = self.viewModel.quoteArray[0].change
        destVC?.changePercentDisplay = self.viewModel.quoteArray[0].changePercent
    }
}





