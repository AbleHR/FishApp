//
//  Trip+CoreDataProperties.swift
//  FishingApp
//
//  Created by Greinke, Matthew M (grein005) on 4/21/16.
//  Copyright © 2016 uwp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trip {

    @NSManaged var date: NSDate?
    @NSManaged var loc_lat: NSNumber?
    @NSManaged var temp: NSNumber?
    @NSManaged var loc_long: NSNumber?
    @NSManaged var condition: String?
    @NSManaged var humidity: NSNumber?
    @NSManaged var wind_mph: NSNumber?
    @NSManaged var visibility_mi: NSNumber?
    @NSManaged var precip: NSNumber?
    @NSManaged var caught: NSManagedObject?

}
