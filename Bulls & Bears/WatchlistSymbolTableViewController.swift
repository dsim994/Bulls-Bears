//
//  WatchlistSymbolTableViewController.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 7/8/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import UIKit
import CoreData

class WatchlistSymbolTableViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var watchlistSymbolTableView: UITableView!
    
    var selectedSymbol : Symbol?
    var insertedIndexPaths: [IndexPath]!
    var deletedIndexPaths: [IndexPath]!
    
    lazy var fetchedResults: NSFetchedResultsController<Symbol> = {
        
        let request = NSFetchRequest<Symbol>(entityName: "Symbol")
        request.predicate = NSPredicate(value: true)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true), NSSortDescriptor(key: "symbol", ascending: true)]
        
        let result = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: CoreDataStack.sharedInstance.context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        result.delegate = self
        
        return result
    }()
    
    func reloadData() {
        
        do {
            try fetchedResults.performFetch()
        } catch  {
            
        }
        
        watchlistSymbolTableView.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .insert:
            insertedIndexPaths.append(newIndexPath!)
            
        case .delete:
            deletedIndexPaths.append(indexPath!)
            
        case .update, .move :
            watchlistSymbolTableView.reloadRows(at: [indexPath!], with: .none)
            watchlistSymbolTableView.reloadRows(at: [newIndexPath!], with: .none)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertedIndexPaths = [IndexPath]()
        deletedIndexPaths = [IndexPath]()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        watchlistSymbolTableView.beginUpdates()
        
        watchlistSymbolTableView.insertRows(at: insertedIndexPaths, with: .automatic)
        
        watchlistSymbolTableView.deleteRows(at: deletedIndexPaths, with: .automatic)
        
        watchlistSymbolTableView.endUpdates()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return fetchedResults.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResults.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WatchlistSymbolTableViewCell.reuseIdentifier, for: indexPath) as! WatchlistSymbolTableViewCell
        
        let symbol = fetchedResults.object(at: indexPath)
        
        cell.nameLabel.text = symbol.name
        cell.symbolLabel.text = symbol.symbol
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        selectedSymbol = fetchedResults.object(at: indexPath)
        
        return indexPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
}






