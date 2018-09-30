//
//  AssetAnotationView.swift
//  AssetTracker
//
//  Created by Jean Pierre on 9/28/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

import Foundation
import MapKit

class AssetAnotationView: MKAnnotationView  {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
       // self.image = kPersonMapPinImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false // This is important: Don't show default callout.
        //self.image = kPersonMapPinImage
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            
        }
        else {
            
        }
        
    }
    
    
    
}
