//
//  WatchlistSymbolTableViewController.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 7/8/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import UIKit
import CoreData

class WatchlistSymbolTableViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var watchlistSymbolTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
