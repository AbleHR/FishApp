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
                            let limit = results.count-1
                            //for rowcount in 0...results.count-1{
                                for rowcount in limit.stride(through: 0, by: -1){
                                let match = results[rowcount] as! NSManagedObject
                          
                                TripLabels.append(match.valueForKey("date") as! NSDate)
                                
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
        print("didsellectrow \(String(targetTrip))")
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
        let count = TripLabels.count
        
        let currentDate = String(String(TripLabels[row]).characters.prefix(10))
//        let cal:NSCalendar = NSCalendar.currentCalendar()
//        let comp = cal.component([.Day , .Month , .Year], fromDate: currentDate)
//        let cellDay = comp.day
            cell.cellDate.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            cell.cellDate.text = currentDate
        
            cell.cellNumber.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            cell.cellNumber.text = "Trip " + String(count - row)
        
        return cell
                
    }
    func reloadTableData(notification: NSNotification) {
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        
        
        print("trip table seque \(String(targetTrip))")
        
        //print(String(targetTrip) + "date from tableView")
            let destination = segue.destinationViewController as! ViewController2
            // fetch information from core data and pass it to the next view
            let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: managedObjectContext)
            let request = NSFetchRequest()
            request.entity = entityDescription
        
            let pred = NSPredicate(format: "(date = %@)", targetTrip )
            request.predicate = pred
        
            do {
                var results = try managedObjectContext.executeFetchRequest(request)
            
            
                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    destination.lat = (match.valueForKey("loc_lat") as? Double)!
                    destination.long = (match.valueForKey("loc_long") as? Double)!
                    destination.date = targetTrip
                } else {
                    
                
                }
            } catch let error as NSError {
                print(error.localizedFailureReason)
            }


            
            
        }
    
}