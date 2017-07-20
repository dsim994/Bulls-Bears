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
    
    /// Replace the reference of NSManagedObject by the custom class if any
    lazy var fetchedResults: NSFetchedResultsController<Symbol> = {
        
        /// Request predicate and sortDescriptors can be changed any time afterwards
        let request = NSFetchRequest<Symbol>(entityName: "Symbol")
        request.predicate = NSPredicate(value: true)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true), NSSortDescriptor(key: "symbol", ascending: true)]
        
        /// sectionNameKeyPath can NOT be modified after
        let result = NSFetchedResultsController(fetchRequest: request,
                                                managedObjectContext: CoreDataStack.sharedInstance.context,
                                                sectionNameKeyPath: nil,
                                                cacheName: nil)
        
        result.delegate = self
        
        return result
    }()
    
    
    /// We only need to perform a new fetch and reload the tableView's data when modifying the predicate or sortDescriptors.
    /// Adding, deleting and updating CoreData objects is taken care of by fetchResults and its delegate methods.
    /// If fetchedResults is set to work with a cache, we would need to delete the cache too.
    func reloadData() {
        
        do {
            try fetchedResults.performFetch()
        } catch  {
            
        }
        
        watchlistSymbolTableView.reloadData()
    }
    
    
    
    
    //MARK: - FETCHED RESULTS DELEGATE
    
    /// Arrays to accumulate all changes from our fetchedResultsController in order to process them in batch
    var insertedIndexPaths: [IndexPath]!
    var deletedIndexPaths: [IndexPath]!
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        ///We accumulate insertions and deletions in order to process them all at once when we receive all changes.
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
        
        /// One or more changes will happen on the data set; we initialize array to
        /// accumulate them in order to process all the changes in batch mode.
        insertedIndexPaths = [IndexPath]()
        deletedIndexPaths = [IndexPath]()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        /// Now the fetched controller is done processing new changes,
        /// we can ask the tableView to update the display for all of them at once.
        
        watchlistSymbolTableView.beginUpdates()
        
        watchlistSymbolTableView.insertRows(at: insertedIndexPaths, with: .automatic)
        
        watchlistSymbolTableView.deleteRows(at: deletedIndexPaths, with: .automatic)
        
        watchlistSymbolTableView.endUpdates()
    }
    
    
    //MARK: - TABLEVIEW DELEGATE & DATASOURCE
    
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
    
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        watchlistSymbolTableView.delegate = self
        watchlistSymbolTableView.dataSource = self
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
