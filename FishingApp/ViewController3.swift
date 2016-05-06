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
    
    
    @IBOutlet weak var length_label: UILabel!
    @IBOutlet weak var weight_label: UILabel!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    
    var species :String = ""
    var lat :Double = 0
    var long :Double = 0
    var length :Double = 0
    var weight :Double = 0
    var date :NSDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveLength(sender: AnyObject) {
        
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)

        let fish = Fish(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        fish.length = Double (sender.value)
        
        do {
            try managedObjectContext.save()
            
        } catch let error as NSError {
            print("errrrr")
        }
        


        
    }

    @IBAction func saveWeight(sender: AnyObject) {
        
        let entityDescription = NSEntityDescription.entityForName("Fish", inManagedObjectContext: managedObjectContext)
        
        let fish = Fish(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        fish.weight = Double (sender.value)
        
        do {
            try managedObjectContext.save()
            
        } catch let error as NSError {
            print("errrrr")
        }
        
    }
    
    
}