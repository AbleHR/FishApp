//
//  Trip+CoreDataProperties.swift
//  FishingApp
//
//  Created by Greinke, Matthew M (grein005) on 4/26/16.
//  Copyright © 2016 uwp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trip {

    @NSManaged var condition: String?
    @NSManaged var date: NSDate?
    @NSManaged var humidity: String?
    @NSManaged var loc_lat: NSNumber?
    @NSManaged var loc_long: NSNumber?
    @NSManaged var precip: String?
    @NSManaged var temp: String?
    @NSManaged var visibility_mi: String?
    @NSManaged var wind_mph: String?
    @NSManaged var caught: NSManagedObject?

}
