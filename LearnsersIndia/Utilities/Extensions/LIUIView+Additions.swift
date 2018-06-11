//
//  LIUIView+Additions.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 06/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadowOnAllSides() {
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOffset = CGSize(width: 10, height: 10)
//        self.layer.masksToBounds = false
//        self.layer.shadowRadius = 1.0
//        self.layer.shadowOpacity = 1
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func dropShadowOnAllSideWithSize(_ size:CGSize) {
   
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: size.width + shadowSize,
                                                   height: size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func dropShadowOnAllSidesWithPath(_ shadowPath:UIBezierPath) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func dropShadowOn(_ top:Bool,bottom:Bool, with size:CGSize) {
        let shadowSize : CGFloat = 5.0
        var y:CGFloat = -shadowSize / 2
        var height:CGFloat = size.height
        let x = -shadowSize / 2
        let width = size.width + shadowSize
        if !top {
            y = y + 1
        }
        if !bottom {
            height = height - 1
        }
        let shadowPath = UIBezierPath(rect: CGRect(x: x, y: y, width: width, height: height))
        self.dropShadowOnAllSidesWithPath(shadowPath)
        

        
        
        
    }
}
