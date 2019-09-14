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
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 350, height: 20))
    
    
    
    
    
    
/*-------------------------------------------------------------------------------------------------*\
\*--------------------------------------------#OUTLETS---------------------------------------------*/
    
    
    
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    
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
    
    func setSearchBar() {
        
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.barStyle = UIBarStyle.blackTranslucent
        searchBar.placeholder = "Enter Company Ticker"
        navigationItem.titleView = searchBar
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        textFieldInsideSearchBar?.textAlignment = .center
        
        

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
    
    

   

    func makeBatchRequest() {
        
        emptyArrays()
        
        let defaultUrl = "https://cloud.iexapis.com/stable/stock/"
        let token = "/batch?token=pk_32107d0097d54d1cbf38641d2923983c"
        let batchRequest = "&types=quote,news,chart&range=1m&last=10"
        let jsonUrl = "\(defaultUrl)\(enteredSymbol)\(token)\(batchRequest)"
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
}










/*-------------------------------------------------------------------------------------------------*\
\*------------------------------------------#SEGUEMETHODS------------------------------------------*/








extension SearchViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destVC = segue.destination as? ResultsViewController
        destVC?.companyNameDisplay = self.viewModel.quoteArray[0].companyName!
        destVC?.symbolDisplay = self.viewModel.quoteArray[0].symbol!
        destVC?.latestPriceDisplay = self.viewModel.quoteArray[0].latestPrice!
        destVC?.changeDisplay = self.viewModel.quoteArray[0].change!
        destVC?.changePercentDisplay = self.viewModel.quoteArray[0].changePercent!
    }
}



extension SearchViewController {
    
    func emptyArrays() {
        
        self.viewModel.quoteArray.removeAll()
        self.viewModel.quoteNewsArray.removeAll()
        
    }
}











