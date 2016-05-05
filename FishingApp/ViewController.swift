//
//  ViewController.swift
//  FishingApp
//
//  Created by Rouse, Able H (rouse013) on 4/14/16.
//  Copyright © 2016 uwp. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let currentDate = NSDate()
    
    let locationManager = CLLocationManager()
    
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
        trip.condition = "test"
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            trip.loc_lat = locationManager.location?.coordinate.latitude
            trip.loc_long = locationManager.location?.coordinate.longitude
        }
        
        
        
        //pull the info from the labels to fill out the attributes to be saved as a trip along with current location
        //trip.date = (pull current date from either the phone or a label)
        
        do{
            //try to save tell user save worked
            try managedObjectContext.save()
            
        }catch let error as NSError {
            
            //tell user that save failed
            errorAlert(self)
            
        }
        
        
        //if did save create new cell in table view
        
        
    
    
        
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

