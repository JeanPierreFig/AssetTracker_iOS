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
        button.setImage(#imageLiteral(resourceName: "options"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "options_selected"), for: UIControlState.selected)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.isToggle = false //let's use this button as a toggle Button
        button.addTarget(self, action:#selector(optionsAction), for: .touchUpInside)
        button.cornerRadius = 15
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let optionsView: MapOptions =  {
        let buttonsView = MapOptions(frame: .zero)
        return buttonsView
    }()
    
    lazy var leadingConstraint = optionsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.mapView.delegate = self
        self.optionsView.delegate = self
        self.view.addSubview(mapView)
        self.view.addSubview(optionsButton)
        self.view.addSubview(optionsView)
        
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        optionsButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        optionsButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
    
        leadingConstraint.isActive = true
        optionsView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        optionsView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        optionsView.bottomAnchor.constraint(equalTo: optionsButton.topAnchor, constant: -20).isActive = true
    }
    
    @objc private func optionsAction(sender: Button) {
        if sender.isToggle! {
            sender.isToggle = false
            sender.isSelected = false
            self.leadingConstraint.constant = -100
            UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
        else {
            sender.isToggle = true
            sender.isSelected = true
            self.leadingConstraint.constant = 10
            UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: MapOptionsDelegate {
    func didSetMapType(type: MKMapType) {
        mapView.mapType = type
    }
}

extension ViewController: MKMapViewDelegate {
    
}

