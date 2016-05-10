//
//  Fish+CoreDataProperties.swift
//  FishingApp
//
//  Created by Greinke, Matthew M (grein005) on 5/10/16.
//  Copyright © 2016 uwp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Fish {

    @NSManaged var date: NSDate?
    @NSManaged var fish_length: NSNumber?
    @NSManaged var loc_lat: NSNumber?
    @NSManaged var loc_long: NSNumber?
    @NSManaged var notes: String?
    @NSManaged var photo: NSObject?
    @NSManaged var species: String?
    @NSManaged var time_stamp: NSDate?
    @NSManaged var weight: NSNumber?
    @NSManaged var relationship: Trip?

}
