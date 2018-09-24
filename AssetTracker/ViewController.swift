//
//  ViewController.swift
//  AssetTracker
//
//  Created by Jean Pierre on 9/24/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let mapView:MKMapView = {
        let map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let optionsButton: Button = {
        let button = Button(frame: .zero)
        button.setTitle("O", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let locationButton: Button = {
        let button = Button(frame: .zero)
        button.setTitle("Satelite", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.view.addSubview(mapView)
        self.view.addSubview(locationButton)
        self.view.addSubview(optionsButton)
        
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        optionsButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        optionsButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

