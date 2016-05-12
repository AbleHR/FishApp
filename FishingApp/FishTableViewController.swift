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
    
    @IBOutlet var fishTable: UITableView!
    
    //display cells
    var fishLabels = [NSDate]()
    var fishSpecies = [String]()
    var fishLength = [Double]()
    var fishWeight = [Double]()
    var fishRows = [AnyObject]()
    var date :NSDate = NSDate()
    var targetFish: NSDate = NSDate()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        print("FishTable didLoad \(String(date))")
        
        //self.tableView.registerClass(TripTableCellView.self, forCellReuseIdentifier: "TripTableCell")
        // tableView.delegate = self
        // tableView.dataSource = self
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
       let pred = NSPredicate(format: "(date = %@)", date )
        request.predicate = pred
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableData:", name: "reload", object: nil)
        
        
        do{
            var results = try managedObjectContext.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for rowcount in 0...results.count-1{
                    let match = results[rowcount] as! NSManagedObject
                    
                    fishLabels.append(match.valueForKey("time_stamp") as! NSDate)
                    
                    fishSpecies.append(match.valueForKey("species") as! String)

                    fishLength.append(match.valueForKey("fish_length") as! Double)
                    
                    fishWeight.append(match.valueForKey("weight") as! Double)
                    
                    
                    
                }//                    if let entrySpecies = row.species!{
//                        fishSpecies.append(entrySpecies)
//                         print(String("made it to species" + String(entrySpecies)))
//                    }
//                    if let entrylength = row.condition{
//                        fishLength.append(entrylength)
//                        print(String("made it to length" + String(entrylength)))
//                    }
//                    if let entryWeight = row.weight!{
//                        fishLength.append(entryWeight)
//                        print(String("made it to weight" + String(entryWeight)))
//                    }
//                    
            }
        } catch let error as NSError{
            
        }
        
        
        tableView.estimatedRowHeight = 20
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        targetFish = fishLabels[indexPath.indexAtPosition(1)]
        print("didsellectrow \(String(targetFish))")
        self.performSegueWithIdentifier("SeguetoView3", sender: self)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
            return fishLabels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FishTableCell", forIndexPath: indexPath) as! FishTableCellView
        
        let row = indexPath.row
        
        cell.fishSpecies.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.fishSpecies.text = fishSpecies[row]

        
        cell.fishLength.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.fishLength.text = String(format: "%.1f", fishLength[row] * 100) + " in"
        
        cell.fishWeight.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.fishWeight.text = String(format: "%.1f", fishWeight[row] * 100) + " oz"
        
        
        
        return cell
        
    }
    func reloadTableData(notification: NSNotification) {
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let destination = segue.destinationViewController as! ViewController3
        
        if (sender === self) {
        
        print("fish table seque \(String(targetFish))")
        // fetch information from core data and pass it to the next view
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(time_stamp = %@)", targetFish )
        request.predicate = pred
        
        do {
            var results = try managedObjectContext.executeFetchRequest(request)
            
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                destination.lat = (match.valueForKey("loc_lat") as? Double)!
                destination.long = (match.valueForKey("loc_long") as? Double)!
                destination.weight = (match.valueForKey("weight") as? Double)!
                destination.length = (match.valueForKey("fish_length") as? Double)!
                destination.species = (match.valueForKey("species") as? String)!
                destination.notes = (match.valueForKey("notes") as? String)!
                destination.time = targetFish
                
                print("Fish weight \(match.valueForKey("weight") as? Double)!)")
                print("Fish length \(match.valueForKey("fish_length") as? Double)!)")
            } else {
                
                
            }
            } catch let error as NSError {
                print(error.localizedFailureReason)
            }
        } else {
          
        }
    }
    
}