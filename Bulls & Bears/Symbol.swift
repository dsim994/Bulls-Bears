//
//  Symbol.swift
//  Bulls & Bears
//
//  Created by Dylan Simerly on 7/19/17.
//  Copyright © 2017 dylansimerly. All rights reserved.
//

import UIKit

import CoreData

extension Symbol {
    
    
    static func getSymbol( _ symbol : String!, name: String! ) -> Symbol! {
        
        let request = NSFetchRequest<Symbol>(entityName: "Symbol")
        request.predicate = NSPredicate( format: "symbol = [cd]%@", symbol )
        do {
            let symbols = try CoreDataStack.sharedInstance.context.fetch(request)
            if symbols.count > 0 {
                return symbols.first!
            }
        } catch {
        }
        
        return Symbol( symbol, name: name )
    }
    
    
    convenience init(_ symbol: String!, name: String! ) {
        
        if let entity = NSEntityDescription.entity(forEntityName: "Symbol", in: CoreDataStack.sharedInstance.context) {
            
            self.init(entity: entity, insertInto: CoreDataStack.sharedInstance.context)
            
            self.symbol = symbol
            
            self.name = name
            
        } else {
            fatalError("Unable to find Entity name Symbol!")
        }
    }
}


