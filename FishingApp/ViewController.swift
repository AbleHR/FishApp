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
    
    var weatherJson: NSString = ""
    var timeInterval = NSDate().timeIntervalSince1970 - 500
    
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
   //         errorAlert(self)
            
        }
        
        
        //if did save create new cell in table view
        
        
    
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //pull from the trip table when the view loads to populate the list ofold trip
        
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
        
        print("start")
        
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
        
        //https://api.wunderground.com/api/417adfddac32a897/conditions/forecast/alert/q/42.6432129,-87.8501127.json
        
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            self.weatherJson = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print(self.weatherJson)
            
            var json: [String: AnyObject]
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! [String: AnyObject] //as? Array
                
                //let output = json["forecast"]
                //print(output)
                
                if let level1 = json["current_observation"] as? [String: AnyObject] {
                    
                    if let level2_weather = level1["weather"] as? String{
                        print(level2_weather)
                    }
                    if let level2_temp = level1["temp_f"] as? Double{
                        print(String(level2_temp) + " F")
                        
                    }
                    if let level2_windspeed = level1["wind_mph"] as? Double{
                        print(String(level2_windspeed) + " mph")
                    }
                    if let level2_visibility = level1["visibility_mi"] as? String{
                        print(level2_visibility + " mi")
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
    


    
    


}

