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

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var date: UITextField!
    
    //link to the create new trip button
    @IBAction func saveTrip(sender: AnyObject) {
    let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: managedObjectContext)
        let trip = Trip(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        //pull the info from the labels to fill out the attributes to be saved as a trip along with current location
        //trip.date = (pull current date from either the phoine or a label)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //pull from the trip table when the view loads to populate the list ofold trips

        
        print("start")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    


}

