//
//  mapOptions.swift
//  AssetTracker
//
//  Created by Jean Pierre on 9/24/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol MapOptionsDelegate {
   func didSetMapType(type: MKMapType)
}

class MapOptions: UIView {
    
    var delegate: MapOptionsDelegate!
    
    let sateliteButton: Button = {
        let button = Button(frame: .zero)
        button.setTitle("Satelite", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.darkGray, for: .selected)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.addTarget(self, action:#selector(sateliteAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let hybridButton: Button = {
        let button = Button(frame: .zero)
        button.setTitle("Hybrid", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.darkGray, for: .selected)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.addTarget(self, action:#selector(hybridAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let mapButton: Button = {
        let button = Button(frame: .zero)
        button.isSelected = true // Set the normal map view as the default map stytle.
        button.setTitle("Normal", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.darkGray, for: .selected)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.addTarget(self, action:#selector(mapAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(hybridButton)
        self.addSubview(sateliteButton)
        self.addSubview(mapButton)
        
        hybridButton.bottomAnchor.constraint(equalTo: sateliteButton.topAnchor, constant: 80).isActive = true
        hybridButton.centerXAnchor.constraint(equalTo: sateliteButton.centerXAnchor).isActive = true
        sateliteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        sateliteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mapButton.topAnchor.constraint(equalTo: sateliteButton.bottomAnchor, constant: -80).isActive = true
        mapButton.centerXAnchor.constraint(equalTo: sateliteButton.centerXAnchor).isActive = true
    }
    
    private func clearSelected() {
        sateliteButton.isSelected = false
        hybridButton.isSelected = false
        mapButton.isSelected = false
    }
    
    @objc private func sateliteAction(sender: Button) {
        self.clearSelected()
        sender.isSelected = true
        delegate.didSetMapType(type: .satellite)
    }
    
    @objc private func hybridAction(sender: Button) {
        self.clearSelected()
        sender.isSelected = true
        delegate.didSetMapType(type: .hybrid)
    }
    
    @objc private func mapAction(sender: Button) {
        self.clearSelected()
        sender.isSelected = true
        delegate.didSetMapType(type: .standard)

    }
    
    deinit {
        print("Map option view is ☠️")
    }
}
