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
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
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
                    
                    fishLabels.append(match.valueForKey("date") as! NSDate)
                    print(String("hi we made it here" + String(match.valueForKey("date"))))
                    
                    fishSpecies.append(match.valueForKey("species") as! String)
                    print(String("hi we made it to species" + String(match.valueForKey("species"))))

                    fishLength.append(match.valueForKey("fish_length") as! Double)
                    print(String("hi we made it to fish_length" + String(match.valueForKey("fish_length"))))
                    
                    fishWeight.append(match.valueForKey("weight") as! Double)
                    print(String("hi we made it to weight" + String(match.valueForKey("weight"))))
                    
                    
                    
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
            print("made it totableviewnumrowsinsection \(fishLabels.count)")
            return fishLabels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FishTableCell", forIndexPath: indexPath) as! FishTableCellView
        
        let row = indexPath.row
        
        cell.fishSpecies.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.fishSpecies.text = String(fishSpecies[row])
        
        cell.fishLength.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.fishLength.text = String(fishLength[row])
        
        cell.fishWeight.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.fishWeight.text = String(fishWeight[row])
        
        print("end of cell creation")
        
        
        
        return cell
        
    }
    func reloadTableData(notification: NSNotification) {
        tableView.reloadData()
    }
    
}