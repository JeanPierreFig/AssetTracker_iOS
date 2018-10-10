//
//  WhiteButton.swift
//  AssetTracker
//
//  Created by Jean Pierre on 9/24/18.
//  Copyright © 2018 Jean Pierre. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    var color: UIColor? //Set the background color.
    var cornerRadius: CGFloat? //set the radius of the button.
    var borderWidth: CGFloat? //Set the boarderWidth of the button.
    var shadowRadius: CGFloat? //Set the dropShadow radius of the button.
    var borderColor: CGColor? //Ser the borderColor of the button.
    var isToggle: Bool? //Use this property to make the button a toggle button.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgorundColor()
        self.buttonPadding()
        self.edgeRadius()
        self.dropShadow()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func backgorundColor(){
        self.backgroundColor =  color ?? UIColor.white
    }
    
    private func buttonPadding() {
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    private func edgeRadius() {
        self.layer.cornerRadius = cornerRadius ?? 6.0
        self.layer.borderWidth = borderWidth ?? 0.0
        self.layer.borderColor = borderColor ?? UIColor.clear.cgColor
        self.layer.masksToBounds = true;
    }
    
    private func dropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = shadowRadius ?? 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:cornerRadius ?? 0.0).cgPath
    }
    
    deinit {
        print("Button is ☠️")
    }
}
