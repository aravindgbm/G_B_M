//
//  LIUtilties.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 22/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import SDWebImage

class LIUtilities: NSObject {
    
    class func showErrorAlertControllerWith(_ message:String?, onViewController:UIViewController ) {
        self.showOkAlertControllerWith(LIConstants.errorAlertTitle, message: message, onViewController: onViewController)
    }
    
    class func showOkAlertControllerWith(_ title:String?, message:String?, onViewController:UIViewController ) {
        
        var alertTitle:String = ""
        var alertMessage:String = ""
        if title == nil{
            alertTitle = ""
        } else {
            alertTitle = title!
        }
        if message == nil {
            alertMessage = ""
        } else{
            alertMessage = message!
        }
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        onViewController.present(alert, animated: true, completion: nil)
        
    }
    
    class func setBorderColor(_ color:UIColor, For view:UIView){
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 1.0
    }
    
    
}
