//
//  ViewController2.swift
//  FishingApp
//
//  Created by Greinke, Matthew M (grein005) on 4/19/16.
//  Copyright © 2016 uwp. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class ViewController2: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /// show users location
        mapView.showsUserLocation = true
        
        mapView.mapType = MKMapType.Hybrid
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    @IBAction func getLongPressCoordinates(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.Began { return }
        let touchLocation = sender.locationInView(mapView)
        let locationCoordinate = mapView.convertPoint(touchLocation, toCoordinateFromView: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
    }
}
