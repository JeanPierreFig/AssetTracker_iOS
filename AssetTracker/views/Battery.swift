//
//  Battery.swift
//  AssetTracker
//
//  Created by Jean Pierre on 9/28/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

import Foundation
import UIKit

class Battery: UIView {
    let body: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 3
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let semiCirle: UIView = {
        let path = UIBezierPath(arcCenter: .zero, radius: 1.6, startAngle: 180, endAngle: -180 , clockwise: true)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.lightGray.cgColor
        let view = UIView(frame: .zero)
        view.layer.addSublayer(layer)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let status: UIView = {
        let view = UIView(frame: .zero)
        view.bounds = view.frame.insetBy(dx: 2, dy: 2)
        view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addSubview(body)
        self.addSubview(semiCirle)
        self.body.addSubview(status)
        self.addSubview(percentLabel)
        
        body.widthAnchor.constraint(equalToConstant: 25).isActive = true
        body.heightAnchor.constraint(equalToConstant: 12).isActive = true
        body.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        body.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        semiCirle.centerYAnchor.constraint(equalTo: body.centerYAnchor).isActive = true
        semiCirle.centerXAnchor.constraint(equalTo: body.centerXAnchor, constant: 14).isActive = true
        
        percentLabel.trailingAnchor.constraint(equalTo: body.leadingAnchor, constant: -2).isActive = true
        percentLabel.centerYAnchor.constraint(equalTo: body.centerYAnchor, constant: 0).isActive = true
    }
    
    func battery(percent: Float) {
        //set label text for percent
        percentLabel.text = "\(percent)%"
        
        //Ilustrate the battery percent in the battery Icon
        status.frame = CGRect(x: 0, y: 0, width: convertPercentToWidth(percent: percent), height: 12)
        status.bounds = status.frame.insetBy(dx: 2, dy: 2)
        
        //set critical color if less then 20%
        if percent <= 20 {
            status.backgroundColor = UIColor.red
        }
        else {
            status.backgroundColor = UIColor.green
        }
    }
    
    private func convertPercentToWidth(percent: Float) -> CGFloat {
        let width = CGFloat(25 * (percent/100))
        //If the battery is less then 20% 5 pixles is the mim we can display on the screen
        if width <= 5 {
            return 5
        }
        return width
    }
    
    deinit {
        print("Battery is ☠️")
    }

}
