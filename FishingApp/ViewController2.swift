//
//  ViewController2.swift
//  FishingApp
//
//  Created by Greinke, Matthew M (grein005) on 4/19/16.
//  Copyright © 2016 uwp. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData
import CoreLocation


class ViewController2: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var newFishButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var lat :Double = 0
    var long :Double = 0
    var date :NSDate = NSDate()
    var timeInterval = NSDate()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        /// show users location
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.Hybrid
        mapView.region.center.latitude = lat
        mapView.region.center.longitude = long
        mapView.removeAnnotations(mapView.annotations)
        let center = mapView.centerCoordinate
        let region = MKCoordinateRegionMakeWithDistance(center, 2000, 2000)
        // set region to current region
        mapView.setRegion(region, animated: true)

        
        /// TODO get all the fish for the trip so we can display them in the table view
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        let request = NSFetchRequest()
        request.entity = entityDescription
        let pred = NSPredicate(format: " (date = %@)", date )
        request.predicate = pred
        
        do {
            var results = try managedObjectContext.executeFetchRequest(request)
            print("The number of fish \(results.count)")
            if results.count > 0 {
                for index in 0...results.count {
                    let match = results[index] as! NSManagedObject
                }
            } else {
                
            }
        } catch let error as NSError {
            print(error.localizedFailureReason)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if(sender === newFishButton) {
        
            let destination = segue.destinationViewController as! ViewController3
        
            let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
            let request = NSFetchRequest()
            request.entity = entityDescription
        
            let pred = NSPredicate(format: "(time_stamp = %@)", timeInterval )
            request.predicate = pred
        
            do {
                var results = try managedObjectContext.executeFetchRequest(request)
                print(timeInterval)
                print(results.count)
                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    destination.species = (match.valueForKey("species") as? String)!
                    destination.long = (match.valueForKey("loc_long") as? Double)!
                    destination.lat = (match.valueForKey("loc_lat") as? Double)!
                    destination.date = (match.valueForKey("date") as? NSDate)!
                    destination.length = (match.valueForKey("fish_length") as? Double)!
                    destination.weight = (match.valueForKey("weight") as? Double)!
                    destination.notes = (match.valueForKey("notes") as? String)!
                    destination.time = timeInterval
                } else {
                
                }
            } catch let error as NSError {
                print(error.localizedFailureReason)
                print("there was an error accessing the fish info")
            }
        }
        else
        {
            let destination = segue.destinationViewController as! FishTableViewController
            
            destination.date = date
        }
    }
    
    
    @IBAction func createFish(sender: AnyObject) {
        timeInterval = NSDate()
        var tempLat = locationManager.location?.coordinate.latitude
        var temLong = locationManager.location?.coordinate.longitude
        
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        let fish = Fish(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        fish.date = date
        
        var timeout = 0
        while (tempLat == nil && temLong == nil && timeout < 200000){
            sleep(1)
            timeout += 1
            tempLat = locationManager.location?.coordinate.latitude
            temLong = locationManager.location?.coordinate.longitude
        }
        fish.loc_lat = tempLat
        fish.loc_long = temLong
        fish.fish_length = 0.75
        fish.weight = 0.25
        fish.species = "Enter the Species"
        fish.time_stamp = timeInterval
        fish.photo = ""
        fish.notes = "Take some notes"
        
        do {
            try managedObjectContext.save()
            print("fish created")
            print(timeInterval)
            
        } catch let error as NSError {
            print("errrrr")
        }
        
        //self.performSegueWithIdentifier("Segue2to3", sender: self)
    }
}
