//
//  ViewController.swift
//  AssetTracker
//
//  Created by Jean Pierre on 9/24/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class ViewController: UIViewController {

    var coordinates = [CLLocationCoordinate2D]()
    var path: MKPolyline!


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
    
    let battery: Battery = {
        let battery = Battery(frame: .zero)
        battery.battery(percent: 90.5)
        battery.translatesAutoresizingMaskIntoConstraints = false
        return battery
    }()
    
    lazy var leadingConstraint = optionsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.getData()
    }
    
    private func setupView() {
        self.mapView.delegate = self
        self.optionsView.delegate = self
        self.view.addSubview(mapView)
        self.view.addSubview(optionsButton)
        self.view.addSubview(optionsView)
        self.view.addSubview(battery)
        
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
        
        battery.widthAnchor.constraint(equalToConstant: 100).isActive = true
        battery.heightAnchor.constraint(equalToConstant: 50).isActive = true
        battery.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        battery.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    //MARK: Buttons
    
    //Show a list of map type to the user using the optionsView
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
    
    private func convertStringCoordinate(string: String) -> CLLocationCoordinate2D {
        let coordinatArray = string.components(separatedBy: ",")
        return CLLocationCoordinate2DMake(Double(coordinatArray[0]) ?? 0.0, Double(coordinatArray[1]) ?? 0.0)
    }
    
    //MARK: Firebase implimentation
    private func getData() {
        let ref =  Database.database().reference(withPath: "gpsdata/data")
        let _ = ref.observe(DataEventType.value, with: { (snapshot) in
           // let locationInfo = snapshot.value as? [String : AnyObject] ?? [:]
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let location = snap.value as! [String: String]
                self.coordinates.append(self.convertStringCoordinate(string: location["G"]!))
            }
    
            self.path = MKPolyline(coordinates: self.coordinates, count: self.coordinates.count)
            let regionRadius: CLLocationDistance = 200
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(self.coordinates.last!,regionRadius * 2.0, regionRadius * 2.0)
            self.mapView.setRegion(coordinateRegion, animated: true)
            self.mapView.addAnnotation(AssetAnotation(coordinate: self.coordinates.last!))
            self.mapView.add(self.path)
        })
    }
    
    
}

//MARK: MapOptionsDelegate

extension ViewController: MapOptionsDelegate {
    func didSetMapType(type: MKMapType) {
        mapView.mapType = type
    }
}

//MARK: MKMapViewDelegate

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            //annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "starbucks")
        return annotationView
    }
    
}

