//
//  ActivityIndicator.swift
//  AutoGradeVTS
//
//  Created by Appzoc on 03/02/18.
//  Copyright © 2018 Appzoc. All rights reserved.
//

import Foundation
import UIKit


class ActivityIndicator{
    
    static var activityView:UIView = UIView()
    static var activitySubview = UIView()
    static var indicator = UIActivityIndicatorView()
    
    static func setUpActivityIndicator(baseView:UIView)
    {
         let width = UIScreen.main.bounds.width
         let height = UIScreen.main.bounds.height
            
        activityView.frame = CGRect(x: 0, y: 0, width: width, height: height)
       
        activitySubview.frame = CGRect(x: width/8.65, y: height/2.25, width: width/1.29, height: 70)
        activitySubview.backgroundColor = UIColor.white
        indicator = UIActivityIndicatorView(frame: CGRect(x: (width/1.29)/5.74, y: 25, width: 20, height: 20))
        indicator.startAnimating()
        indicator.color = R_UIColor.darkColor
        let activityLabel = UILabel(frame: CGRect(x: (width/1.29)/2.97, y: 25, width: 80, height: 21))
        activityLabel.text = "Loading..."
        activitySubview.addSubview(indicator)
        activitySubview.addSubview(activityLabel)
        activityView.addSubview(activitySubview)
        activityView.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.3)
        baseView.addSubview(activityView)
        
        
    }
    
    static func dismissActivityView(){
        DispatchQueue.main.async {
            //activityView.isHidden = true
           // activitySubview.removeFromSuperview()
            activityView.removeFromSuperview()
        }
        
    }
    
    
    
}
