//
//  R_Helper.swift
//  Romana
//
//  Created by Appzoc-Macmini on 16/11/17.
//  Copyright © 2017 Appzoc-Macmini. All rights reserved.
//

import UIKit
 let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
enum ActivityStatus
{
    case show
    case hide
}

class R_Helper
{

    class func AlertFunction(title: String, message: String, viewContoller: UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        viewContoller.present(alert, animated: true, completion: nil)
    }
   
    
    class func AlertFunctionWithAction(title: String, message: String, viewContoller: UIViewController,alertFunction: @escaping () -> Void)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            print("action yes handler")
            alertFunction()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        viewContoller.present(alert, animated: true, completion: nil)
        
    }

    
    
    class func ActivityIndicatory(uiView: UIView, status: ActivityStatus)
   {
    
    activityIndicator.isHidden = true
    activityIndicator.hidesWhenStopped = true
    if status == .show
    {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        //    CGRectMake(0.0, 0.0, 40.0, 40.0);
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.transform = transform
        activityIndicator.center = uiView.center
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.gray
        uiView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    else
    {
        activityIndicator.stopAnimating()
    }
   
}




}


