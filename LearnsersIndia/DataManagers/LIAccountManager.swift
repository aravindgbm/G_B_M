//
//  LIAccountManager.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 21/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIAccountManager: NSObject {
    static let sharedInstance = LIAccountManager()
    let savedAccessTokenKey = "savedAccessToken"
    let savedUserDetails = "savedUserDetails"
    
    func getAccesToken() -> String?{
        
        if let accessToken:String = UserDefaults.standard.object(forKey: savedAccessTokenKey) as! String? {
            return accessToken
        } else {
            return ""
        }
    }
    
    func setAccessToken(_ accessToken:String){
        UserDefaults.standard.set(accessToken, forKey: savedAccessTokenKey)
        UserDefaults.standard.synchronize()
    }
    
    func isUserLoggedIn() -> Bool{
        
        let accessToken = getAccesToken()
        if (accessToken?.count)! > 0{
            return true
        } else {
            return false
        }
        
    }
    
//    func getLoggedInUser() -> SPUserModel?{
//
//        if let archievedUserModel = UserDefaults.standard.object(forKey: savedUserDetails) as? Data {
//
//            if let userModel = NSKeyedUnarchiver.unarchiveObject(with: archievedUserModel) as? SPUserModel {
//                return userModel
//            } else {
//                return nil
//            }
//
//        } else {
//            return nil
//        }
//    }
    
//    func setLoggedInUser(_ userDetails:SPUserModel?){
//
//        if userDetails != nil {
//
//            let archivedUserModel = NSKeyedArchiver.archivedData(withRootObject: userDetails!)
//            UserDefaults.standard.set(archivedUserModel, forKey: savedUserDetails)
//            UserDefaults.standard.synchronize()
//
//        }
//    }
    
    func removeLoggedInUserAndToken() {
        
        if let _  = UserDefaults.standard.object(forKey: savedUserDetails) {
            UserDefaults.standard.removeObject(forKey: savedUserDetails)
        }
        if let _  = UserDefaults.standard.object(forKey: savedAccessTokenKey) {
            UserDefaults.standard.removeObject(forKey: savedAccessTokenKey)
        }
        
    }
    
    
   
    
    
}
