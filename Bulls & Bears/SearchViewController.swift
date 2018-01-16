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
        makeQuoteRequest()
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
    func makeQuoteRequest() {
        let stockUrl = "https://api.iextrading.com/1.0/stock/"
        let quoteRequest = "/quote?displayPercent=true)"
//        let batchRequest = "/batch"
        
        let jsonUrl = "\(stockUrl)\(enteredSymbol)\(quoteRequest)"
        let url = URL(string: jsonUrl)
        
        URLSession.shared.dataTask(with: url!) { (data, resoponse, err) in
            guard let data = data else { return }
            do {
                let fetchedQuotes = try JSONDecoder().decode(Quote.self, from: data)
                self.viewModel.quotes.append(fetchedQuotes)
                DispatchQueue.main.async() {
                    self.performSegue(withIdentifier: "showResults", sender: self)
                }

            } catch {
                print("Error Parsing JSON")
            }
        }.resume()
    }
}

/*-------------------------------------------------------------------------------------------------*\
\*------------------------------------------#SEGUEMETHODS------------------------------------------*/

extension SearchViewController {
    
    //Segue Method Attaches Returned Quotes To Variables
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as? ResultsViewController
        destVC?.companyNameDisplay = self.viewModel.quotes[0].companyName
        destVC?.symbolDisplay = self.viewModel.quotes[0].symbol
        destVC?.latestPriceDisplay = self.viewModel.quotes[0].latestPrice
        destVC?.changeDisplay = self.viewModel.quotes[0].change
        destVC?.changePercentDisplay = self.viewModel.quotes[0].changePercent
    }
}





