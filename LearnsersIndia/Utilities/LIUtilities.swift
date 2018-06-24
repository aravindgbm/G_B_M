//
//  LIUtilties.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 22/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

class LIUtilities: NSObject {
    
    class func showErrorAlertControllerWith(_ message:String?, onViewController:UIViewController ) {
        self.showOkAlertControllerWith(LIConstants.errorAlertTitle, message: message, onViewController: onViewController)
    }
    
    class func showOkAlertControllerWith(_ title:String?, message:String?, onViewController:UIViewController ) {
        
//        var alertTitle:String = ""
//        var alertMessage:String = ""
//        if title == nil{
//            alertTitle = ""
//        } else {
//            alertTitle = title!
//        }
//        if message == nil {
//            alertMessage = ""
//        } else{
//            alertMessage = message!
//        }
//        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alert.addAction(okAction)
//        onViewController.present(alert, animated: true, completion: nil)
        self.showOkAlertControllerWith(title, message: message, onViewController: onViewController, with: nil)
        
    }
    class func showOkAlertControllerWith(_ title:String?, message:String?, onViewController:UIViewController, with completion:((UIAlertAction) -> Void)? ) {
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
//        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            if let _ = completion {
                completion!(action)
            }
        }
        alert.addAction(okAction)
        onViewController.present(alert, animated: true, completion: nil)
    }
    class func setBorderColor(_ color:UIColor, For view:UIView){
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 1.0
    }
    
    class func setBorderColor(_ color:UIColor,with borderWidth:CGFloat,For view:UIView) {
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = borderWidth
    }
    
    class func getQuestionAskedTextWith(_ subject:String?,timestamp:String?) -> String? {
        if let _ = timestamp {
            let doubleTimestamp = Double(timestamp!)
            if let _ = doubleTimestamp {
                let date = Date(timeIntervalSince1970: doubleTimestamp!)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let stringDate = dateFormatter.string(from: date)
                return "Asked in \(subject ?? "") on \(stringDate)"
            }
        }
        return nil
    }
    class func getAnswerCountLabelTextWith(_ answerCount:Int?) -> String{
        var answerCountDetailsText = LIConstants.noAnswerString
        if let answers = answerCount {
            if answers == 1 {
                answerCountDetailsText = String(answers) + LIConstants.singleAnswerString
            }
            else if (answers > 1) {
                answerCountDetailsText = String(answers) + LIConstants.multipleAnswerString
            }
        }
        return answerCountDetailsText
    }
    class func getAnsweredTextWith(_ timestamp:Int?) -> String? {
        if let _ = timestamp {
            let doubleTimestamp = Double(timestamp!)
                let date = Date(timeIntervalSince1970: doubleTimestamp)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let stringDate = dateFormatter.string(from: date)
                return "Answered on \(stringDate)"
        }
        return nil
    }
    
    class func playVideoWithObject(_ videoObject:LIVideoModel?, on viewController:UIViewController) {
        if let _ = videoObject {
            let paidUser = LIAccountManager.sharedInstance.getLoggedInUser()?.isPaidUser ?? false
            let paidVideo = videoObject?.isPaidVideo ?? true
            if (paidVideo && paidUser) || !paidVideo {
                if let videoUrlString = videoObject?.videoPrivateUrl{
                    if let videoUrl = URL(string: videoUrlString){
                        let player = AVPlayer(url: videoUrl)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        viewController.present(playerViewController, animated: true) {
                            playerViewController.player?.play()
                        }
                    }
                }
            }
            else {
                LIUtilities.showOkAlertControllerWith(LIConstants.titleSorry, message: LIConstants.paidVideoAlertMessage, onViewController: viewController)
            }
        }
        
    }
    class func showLogoutAlertOnViewController(_ viewController:UIViewController){
        let alert = UIAlertController(title: LIConstants.logoutAlertTitle, message: LIConstants.logoutAlertMessage, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(noAction)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            LIUtilities.logoutTheUser()
        }
        alert.addAction(yesAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func logoutTheUser(){
        LIAccountManager.sharedInstance.removeLoggedInUserAndToken()
        AppDelegate.getAppDelegateInstance().navigateToTutorialScreen()
    }
    
    class func getAttributedStringFromHtmlString( _ htmlString:String) -> NSAttributedString?{
        if let htmlData = htmlString.data(using: String.Encoding.unicode) {
            do {
                return try NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            } catch let e as NSError {
                print("Couldn't translate \(htmlString): \(e.localizedDescription) ")
                return nil
            }
        }
        return nil
    }
    
    class func showQuitGameALertOnViewController(_ viewController:UIViewController){
        let alert = UIAlertController(title: LIConstants.quitGameAlertTitle, message: LIConstants.quitGameAlertMessage, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(noAction)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            viewController.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(yesAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
