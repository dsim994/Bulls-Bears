//
//  SearchViewController.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/22/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SearchViewController: YahooFinanceViewController {
    
    static let identifier = "SearchViewController"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = self
        self.setSearchBar()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setSearchBar() {

        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        self.searchBar.delegate = self
        self.searchBar.rx.searchButtonClicked.bind {
            Observable.just(self.searchBar.text).filter({
                ($0 != nil && $0!.trimmingCharacters(in: .whitespaces) != "")
            }).bind(onNext: { (string: String?) in
                self.viewModel.searchStart(inputString: string!)
            }).addDisposableTo(self.disposeBag)
            }.addDisposableTo(self.disposeBag)
        }
    }

extension SearchViewController: SearchViewModel {
    
    func showLoading() {
        self.showLoadingView()
    }
    
    func hideLoading() {
        self.hideLoadingView()
    }
    
    
    func searchSuccess(results: [Result]) {
        
        let symbolTableViewController = self.mainStoryboard.instantiateViewController(withIdentifier: SymbolTableViewController.identifier) as! SymbolTableViewController
        SymbolViewModelData.sharedData.results = results
        self.navigationController?.pushViewController(symbolTableViewController, animated: true)
    }
    
    func searchFail(error: NSError?) {
        let title = self.viewModel.getTexts(.failDefaultTitle)
        let failMessage = self.viewModel.getTexts(.failMessage)
        let failDefaultMessage = self.viewModel.getTexts(.failDefaultMessage)
        self.showPopup(title: (error?.code != nil ? String(error!.code) : title), message: (error != nil ? failMessage : failDefaultMessage), completionHandler: { (complete) in
            self.searchBar.becomeFirstResponder()
        })
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

