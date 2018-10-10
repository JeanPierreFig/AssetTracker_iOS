//
//  CardModelViewController.swift
//  AssetTracker
//
//  Created by Jean Pierre on 9/30/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

import UIKit
import MapKit

class CardModelViewController: UIViewController, HalfModalPresentable {
    
    var assetdData: AssetData!
    var coordinates: [CLLocationCoordinate2D]!
    
    let battery: Battery = {
        let battery = Battery(frame: .zero)
        battery.translatesAutoresizingMaskIntoConstraints = false
        return battery
    }()
    
    let lastUpdateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let distancelabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deleteButton: Button = {
        let button = Button(frame: .zero)
        button.setTitle("Delete Track", for: .normal)
        button.cornerRadius = 10
        button.color = UIColor.red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.gray, for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action:#selector(delete), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setData()
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(battery)
        self.view.addSubview(deleteButton)
        self.view.addSubview(lastUpdateLabel)
        self.view.addSubview(distancelabel)
    
        battery.widthAnchor.constraint(equalToConstant: 50).isActive = true
        battery.heightAnchor.constraint(equalToConstant: 35).isActive = true
        battery.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        battery.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        
        lastUpdateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        lastUpdateLabel.centerYAnchor.constraint(equalTo: battery.centerYAnchor, constant: 0).isActive = true
        
        distancelabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        distancelabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
        deleteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
        
        
    }
    
    private func setData() {
        self.battery.battery(percent: assetdData!.battery)
        let date = serverToLocal(date:(assetdData?.timeStamp)!)
        self.lastUpdateLabel.text = "\(date!)"
        self.distancelabel.text = String(format: "%.2f miles",calculateDistance(coordinates: coordinates))
    }
    
    private func serverToLocal(date:String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "EE HH:mm a"
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    
    private func calculateDistance(coordinates: [CLLocationCoordinate2D]) -> CLLocationDistance {
        var totalMiles:CLLocationDistance  = 0;
      
        for i in 0..<(coordinates.count-1) {
            let coor1 = CLLocation(latitude:coordinates[i].latitude, longitude: coordinates[i].longitude)
            let coor2 = CLLocation(latitude: coordinates[(i+1)].latitude, longitude: coordinates[(i+1)].longitude)
            let distance =  coor1.distance(from: coor2)
            let miles:CLLocationDistance = distance / 1609.344
            totalMiles += miles
        }
        print(totalMiles)
        return totalMiles
    }
}
