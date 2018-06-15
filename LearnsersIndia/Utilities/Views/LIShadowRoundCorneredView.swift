//
//  LIShadowRoundCorneredView.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 11/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIShadowRoundCorneredView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var shadowLayer: CAShapeLayer!
    var shouldRefreshView:Bool = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            self.dropShadow()
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
    func dropShadow(){
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowRadius = 2
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func refreshView(){
        if shouldRefreshView && self.shadowLayer != nil {
            self.shadowLayer.removeFromSuperlayer()
            self.dropShadow()
            self.shouldRefreshView = false
        }
    }


}
