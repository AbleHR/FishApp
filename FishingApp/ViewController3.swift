//
//  ViewController3.swift
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


class ViewController3: UIViewController {
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    @IBOutlet weak var fishLocation: MKMapView!
    @IBOutlet weak var lengthSlider: UISlider!
    @IBOutlet weak var lengthValueLabel: UILabel!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var weightValueLabel: UILabel!
    @IBOutlet weak var saveNotesButton: UIButton!
    @IBOutlet weak var speciesTextfield: UITextField!
    
    @IBOutlet weak var Back3: UIButton!
    var species :String = ""
    var lat :Double = 0
    var long :Double = 0
    var length :Double = 0.0
    var weight :Double = 0.0
    var date :NSDate = NSDate()
    var time :NSDate = NSDate()
    var notes :String = ""
    
    let fishPin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize the input fields
        lengthSlider.value = Float(length)
        weightSlider.value = Float(weight)
        notesText.text = notes
        speciesTextfield.text = species

        lengthValueLabel.text = String(format: "%.1f", length * 100) + " in"
        weightValueLabel.text = String(format: "%.1f", weight * 100) + " oz"

        
        // map stuff
        fishLocation.mapType = MKMapType.Hybrid
        fishLocation.region.center.latitude = lat
        fishLocation.region.center.longitude = long
        fishLocation.removeAnnotations(fishLocation.annotations)
        let center = fishLocation.centerCoordinate
        let region = MKCoordinateRegionMakeWithDistance(center, 500, 500)
        // set region to current region
        fishLocation.setRegion(region, animated: true)
        
        
        fishPin.coordinate.latitude = lat
        fishPin.coordinate.longitude = long
        fishPin.title = species
        self.fishLocation.addAnnotation(fishPin)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveLength(sender: UISlider) {
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        request.predicate = NSPredicate(format: "time_stamp = %@", time)
        
        do {
            if var results = try managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if results.count != 0 {
                    let managedObject = results[0]
                    managedObject.setValue(sender.value, forKey: "fish_length")
                    try managedObjectContext.save()
                }
            }
        } catch let error as NSError {
            print(error.localizedFailureReason)
        }
        lengthValueLabel.text = String(format: "%.1f", sender.value * 100) + " in"
        
    }

    @IBAction func saveNotes(sender: UIButton) {
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        request.predicate = NSPredicate(format: "time_stamp = %@", time)
        
        do {
            if var results = try managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if results.count != 0 {
                    let managedObject = results[0]
                    managedObject.setValue(notesText.text, forKey: "notes")
                    try managedObjectContext.save()
                }
            }
        } catch let error as NSError {
            print(error.localizedFailureReason)
        }
    }

    @IBAction func saveSpecies(sender: UITextField) {
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        request.predicate = NSPredicate(format: "time_stamp = %@", time)
        
        do {
            if var results = try managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if results.count != 0 {
                    let managedObject = results[0]
                    managedObject.setValue(sender.text, forKey: "species")
                    try managedObjectContext.save()
                }
            }
        } catch let error as NSError {
            print(error.localizedFailureReason)
        }
    }
    
    @IBAction func saveWeight(sender: UISlider) {
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        request.predicate = NSPredicate(format: "time_stamp = %@", time)
        
        do {
            if var results = try managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if results.count != 0 {
                    let managedObject = results[0]
                    managedObject.setValue(sender.value, forKey: "weight")
                    try managedObjectContext.save()
                }
            }
        } catch let error as NSError {
            print(error.localizedFailureReason)
        }
        weightValueLabel.text = String(format: "%.1f", sender.value * 100) + " oz"
    }
    
    @IBAction func getLongPressCoordinates(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.Began { return }
        let touchLocation = sender.locationInView(fishLocation)
        let locationCoordinate = fishLocation.convertPoint(touchLocation, toCoordinateFromView: fishLocation)
       // print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        request.predicate = NSPredicate(format: "time_stamp = %@", time)
        
        do {
            if var results = try managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if results.count != 0 {
                    let managedObject = results[0]
                    managedObject.setValue(locationCoordinate.latitude, forKey: "loc_lat")
                    managedObject.setValue(locationCoordinate.longitude, forKey: "loc_long")
                    try managedObjectContext.save()
                }
            }
        } catch let error as NSError {
            print(error.localizedFailureReason)
        }
        
        fishPin.coordinate.latitude = locationCoordinate.latitude
        fishPin.coordinate.longitude = locationCoordinate.longitude
        fishLocation.region.center.latitude = locationCoordinate.latitude
        fishLocation.region.center.longitude = locationCoordinate.longitude

        
    }
    

}