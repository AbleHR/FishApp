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

class FishTableViewController: UITableViewController {
    
    //display cells
    var TripLabels = [NSDate]()
    var tripRows = [AnyObject]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // update the table
        
        let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: managedObjectContext)
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        do{
            var results = try managedObjectContext.executeFetchRequest(request)
            print(String("hi we made it here0"))
            if results.count > 0 {
                print(String("hi we made it here1"))
                
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
        tableView.estimatedRowHeight = 20
    }
    

    func reloadTableData(notification: NSNotification) {
        tableView.reloadData()
    }
    
}