//
//  AssetAnotation.swift
//  AssetTracker
//
//  Created by Jean Pierre on 9/28/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

import Foundation
import MapKit
class AssetAnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
  
    
}
