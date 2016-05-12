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
    let locationManager = CLLocationManager()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var Visibility: UILabel!
    @IBOutlet weak var NewTrip: UIButton!
    @IBOutlet weak var Temp: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var Weather: UILabel!

   
    
    let currentDate = NSDate()
    var weatherJson: NSString = ""
    var timeInterval = NSDate().timeIntervalSince1970 - 500
    var date: NSDate = NSDate()
    var lat: Double = 0
    var long: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        //pull from the trip table when the view loads to populate the list ofold trip
        
        //pull from the trip table when the view loads to populate the list ofold trip
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
    //link to the create new trip button
    @IBAction func newtrip(sender: AnyObject) {
    let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: managedObjectContext)
        let trip = Trip(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        date = NSDate()
        var tempLat = locationManager.location?.coordinate.latitude
        var tempLong = locationManager.location?.coordinate.longitude
        var timeout = 0
        while (tempLat == nil && tempLong == nil && timeout < 200000){
            sleep(1)
            timeout += 1
            tempLat = locationManager.location?.coordinate.latitude
            tempLong = locationManager.location?.coordinate.longitude
            print("waiting")
        }

        trip.date = date
        trip.temp = Temp.text!
        trip.visibility_mi = Visibility.text!
        trip.wind_mph = WindSpeed.text!
        trip.weather = Weather.text!
        trip.condition = "It worked from controller 1"
        
        locationManager.delegate = self
        trip.loc_lat = tempLat
        trip.loc_long = tempLong
        lat = tempLat!
        long = tempLong!

        
        do{
            try managedObjectContext.save()
        }catch let error as NSError {
            print("Failed Save with error \(error)")
        }
        
        //self.performSegueWithIdentifier("Segue1to2", sender: self)
    }
    
   
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        // updates every 5minutes
        if(NSDate().timeIntervalSince1970 > timeInterval + 300){
            timeInterval = NSDate().timeIntervalSince1970
            getWeather(locValue.latitude, long: locValue.longitude)
        }
    }
    
    func getWeather(lat: Double, long: Double){
        let newLat = String(lat)
        let newLong = String(long)
        let urlString = "https://api.wunderground.com/api/417adfddac32a897/conditions/forecast/alert/q/" + newLat + "," + newLong + ".json"
        let url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.weatherJson = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            var json: [String: AnyObject]
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! [String: AnyObject] //as? Array
                if let level1 = json["current_observation"] as? [String: AnyObject] {
                    if let level2_weather = level1["weather"] as? String{
                        print(level2_weather)
                        dispatch_async(dispatch_get_main_queue()) {
                            self.Weather.text = level2_weather
                        }
                    }
                    if let level2_temp = level1["temp_f"] as? Double{
                        print(String(level2_temp) + " F")
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.Temp.text = String (level2_temp) + " F"
                            
                        }
                        
                    }
                    if let level2_windspeed = level1["wind_mph"] as? Double{
                        print(String(level2_windspeed) + " mph")
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.WindSpeed.text = String (level2_windspeed) + " mph"
                            
                        }
                    }
                    if let level2_visibility = level1["visibility_mi"] as? String{
                        print(level2_visibility + " mi")
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.Visibility.text = level2_visibility + " mi"
                            
                        }
                    }
                }
            }
            catch {
                print("No weather data")
            }
        }
        task.resume()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (sender === NewTrip) {
        
            let destination = segue.destinationViewController as! ViewController2
            
            destination.date = date
            print("view seque date \(String(date))")

            destination.lat = lat
            destination.long = long
            
            // fetch information from core data and pass it to the next view
  //          let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: managedObjectContext)
 //           let request = NSFetchRequest()
 //           request.entity = entityDescription
//            
//            let pred = NSPredicate(format: "(date = %@)", date )
//            request.predicate = pred
//        
//            do {
//                var results = try managedObjectContext.executeFetchRequest(request)
//            
//                print(results.count)
//            
//                if results.count > 0 {
//                    let match = results[0] as! NSManagedObject
//                        destination.lat = (match.valueForKey("loc_lat") as? Double)!
//                        destination.long = (match.valueForKey("loc_long") as? Double)!
//                        destination.date = (match.valueForKey("date") as? NSDate)!
//                } else {
//                    print("Nothing added to coreData in View1")
//                }
//            } catch let error as NSError {
//                print(error.localizedFailureReason)
//            }
            
        } // end if
    
        
    }


    
    


}

