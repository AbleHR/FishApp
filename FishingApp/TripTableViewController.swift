//
//  TripTableViewController.swift
//  FishingApp
//
//  Created by Greinke, Matthew M (grein005) on 4/28/16.
//  Copyright © 2016 uwp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TripTableViewController: UITableViewController {
    
    //display cells
    var TripLabels = [NSDate]()
    var tripRows = [AnyObject]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        
        do{
            var results = try managedObjectContext.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for var row in results  {
                    tripRows.append(row)
                    if let date = row.date{
                        TripLabels.append(date!)
                    }
                    print(String("hi we made it here" + String(row.date)))
                    
                }
                
            }else{
                
            }
        } catch let error as NSError{
            
        }
        
        
      // TripLabels =
    }
   
}

