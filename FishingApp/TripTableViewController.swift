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

class TripTableViewController: UITableViewController{
    
    @IBOutlet weak var triptable: UITableView!
    //display cells
    var TripLabels = [NSDate]()
    var tripRows = [AnyObject]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var targetTrip: NSDate = NSDate()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //self.tableView.registerClass(TripTableCellView.self, forCellReuseIdentifier: "TripTableCell")
        // tableView.delegate = self
        // tableView.dataSource = self
        let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableData:", name: "reload", object: nil)
        
        
        do{
                        var results = try managedObjectContext.executeFetchRequest(request)
            
                        if results.count > 0 {
            
                            for var row in results  {
                                tripRows.append(row)
                                if let entryDate = row.date! {
                                    TripLabels.append(entryDate)
                                }else{
                                    print("empty date in row")
                                }
            
            
                            }
                            
                            
                            
//                            for var row in results{
//                                print("\(row)")
//                                tripRows.append(row)
//                                if let entryDate = row.date! {
//                                    TripLabels.append(entryDate)
//                                    print(String("hi we made it here" + String(entryDate)))
//                                }else{
//                                    print("empty date in row")
//                                }
//            
//            
//                            }
//            
//                        }else{
//                            
                        }
                    } catch let error as NSError{
                        
                    }
                    
                    
                    tableView.estimatedRowHeight = 20
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        targetTrip = TripLabels[indexPath.indexAtPosition(1)]
        self.performSegueWithIdentifier("SequetoView2", sender: self)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
            return TripLabels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCellWithIdentifier("TripTableCell", forIndexPath: indexPath) as! TripTableCellView
       
                let row = indexPath.row
                    cell.cellDate.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
                    cell.cellDate.text = String(TripLabels[row])
               // }else{
                //    print("no cell")
               // }
                
                
                return cell
                
            }
    func reloadTableData(notification: NSNotification) {
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if(sender === tableView) {
        
            print(String(targetTrip) + "In tripTable segue")
            let destination = segue.destinationViewController as! ViewController2
            // fetch information from core data and pass it to the next view
            let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: managedObjectContext)
            let request = NSFetchRequest()
            request.entity = entityDescription
        
            let pred = NSPredicate(format: "(date = %@)", targetTrip )
            request.predicate = pred
        
            do {
                var results = try managedObjectContext.executeFetchRequest(request)
            
                print(results.count)
            
                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    destination.lat = (match.valueForKey("loc_lat") as? Double)!
                    destination.long = (match.valueForKey("loc_long") as? Double)!
                    destination.date = (match.valueForKey("date") as? NSDate)!
                    print(String((match.valueForKey("date") as? NSDate)!) + "date from tableView")
                } else {
                
                }
            } catch let error as NSError {
                print(error.localizedFailureReason)
            }

        }
    } // end if
    
}