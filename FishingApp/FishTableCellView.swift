//
//  FishTableCellView.swift
//  FishingApp
//
//  Created by Greinke, Matthew M (grein005) on 5/10/16.
//  Copyright © 2016 uwp. All rights reserved.
//

import Foundation
import UIKit
//seque in to next view
//display data from core data

class FishTableCellView: UITableViewCell{
    
    @IBOutlet weak var fishSpecies: UILabel!

    @IBOutlet weak var fishLength: UILabel!
    
    @IBOutlet weak var fishWeight: UILabel!
    
}
