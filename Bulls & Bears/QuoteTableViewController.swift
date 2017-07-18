//
//  QuoteTableViewController.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 4/23/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class QuoteTableViewController: YahooFinanceViewController {

    static let identifier = "QuoteTableViewController"
    
    @IBOutlet var quoteTableView: UITableView!
    
    var viewModel: QuoteViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "+Watchlist",
            style: .plain,
            target: self,
            action: #selector(addToWatchlistPressed))
        
        self.viewModel = self
        self.setQuoteTableView()
        self.showQuoteTableView()
    }
    
    func setQuoteTableView() {
        self.quoteTableView.allowsSelection = false
        self.quoteTableView.rowHeight = QuoteTableViewCell.expectedHeight
    }
    
    func showQuoteTableView() {
        let quotesContents = Variable(self.viewModel.quotes[0].toJSON())
        quotesContents.asObservable().bind(to: self.quoteTableView.rx.items(cellIdentifier: QuoteTableViewCell.reuseIdentifier, cellType: QuoteTableViewCell.self)) { (row, element, cell) in
            cell.keyLabel.text = element.0
            cell.valueLabel.text = String(describing: element.1)
            }.addDisposableTo(disposeBag)
        }
    }

extension QuoteTableViewController: QuoteViewModel {
    
    func refreshUI() {
        self.showQuoteTableView()
    }
    
    func addToWatchlistPressed(sender: UIBarButtonItem){
        print("Clicked")
        performSegue(withIdentifier: "+WatchlistPressed", sender: nil)
    }
}

