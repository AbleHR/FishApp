//
//  ViewController.swift
//  FishingApp
//
//  Created by Rouse, Able H (rouse013) on 4/14/16.
//  Copyright © 2016 uwp. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    let currentDate = NSDate()
    
    

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var Temp: UILabel!
    @IBOutlet weak var Visablity: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    
    
    @IBOutlet weak var date: UITextField!
    
    
    
    
    
    
    
    
    
    //link to the create new trip button
    @IBAction func saveTrip(sender: AnyObject) {
    let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: managedObjectContext)
        let trip = Trip(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        trip.date = currentDate
        trip.temp = Temp.text!
        trip.visibility_mi = Visablity.text!
        trip.wind_mph = WindSpeed.text!
        trip.humidity = Humidity.text!
        
        //trip.loc_lat = pull from phone
        //trip.loc_long = pull from phone
        
        
        
        //pull the info from the labels to fill out the attributes to be saved as a trip along with current location
        //trip.date = (pull current date from either the phone or a label)
        
        do{
            //try to save tell user save worked
            try managedObjectContext.save()
            
        }catch let error as NSError {
            
            //tell user that save failed
            
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //pull from the trip table when the view loads to populate the list ofold trip
        
        
        
        
        
        
        
        print("start")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    


}

