//
//  ViewController3.swift
//  FishingApp
//
//  Created by Greinke, Matthew M (grein005) on 4/19/16.
//  Copyright © 2016 uwp. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation


class ViewController3: UIViewController {
    
    

    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    
    var species :String = ""
    var lat :Double = 0
    var long :Double = 0
    var length :Double = 0
    var weight :Double = 0
    var date :NSDate = NSDate()
    var time :NSDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("this should be our identifier \(time)")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveLength(sender: UISlider) {
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        
        print("we made it in")
        let request = NSFetchRequest()
        request.entity = entityDescription
        request.predicate = NSPredicate(format: "time_stamp = %@", time)
        
        do {
            if var results = try managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                print("the count is \(results.count)")
                if results.count != 0 {
                    let managedObject = results[0]
                    print(sender.value)
                    //managedObject.setValue(sender.value, forKey: "length")
                    
                    try managedObjectContext.save()
                }
            }
        } catch let error as NSError {
            print(error.localizedFailureReason)
        }


        
    }

    @IBAction func saveWeight(sender: AnyObject) {
        
        
        
        
//        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
//        
//        let fish = Fish(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
//        fish.weight = Double (sender.value)
//        
//        do {
//            try managedObjectContext.save()
//            
//        } catch let error as NSError {
//            print("errrrr")
//        }
        
    }
    
    
}