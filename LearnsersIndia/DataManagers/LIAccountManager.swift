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
    let savedOTP = "savedOTP"
    
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
            
            if let isOtpVerified = getLoggedInUser()?.isOTPVerified {
                
                return (accessToken?.count)! > 0 && isOtpVerified
        }
            else{
                return false
            }
            
        } else {
            return false
        }
        
    }
    
    func getLoggedInUser() -> LIUserModel?{

        if let archievedUserModel = UserDefaults.standard.object(forKey: savedUserDetails) as? Data {

            if let userModel = NSKeyedUnarchiver.unarchiveObject(with: archievedUserModel) as? LIUserModel {
                return userModel
            } else {
                return nil
            }

        } else {
            return nil
        }
    }
    
    func setLoggedInUser(_ userDetails:LIUserModel?){

        if userDetails != nil {

            let archivedUserModel = NSKeyedArchiver.archivedData(withRootObject: userDetails!)
            UserDefaults.standard.set(archivedUserModel, forKey: savedUserDetails)
            UserDefaults.standard.synchronize()

        }
    }
    
    func removeLoggedInUserAndToken() {
        
        if let _  = UserDefaults.standard.object(forKey: savedUserDetails) {
            UserDefaults.standard.removeObject(forKey: savedUserDetails)
        }
        if let _  = UserDefaults.standard.object(forKey: savedAccessTokenKey) {
            UserDefaults.standard.removeObject(forKey: savedAccessTokenKey)
        }
        
    }
    
    func saveOTPForTheUser(_ otp:String) {
        UserDefaults.standard.set(otp, forKey: savedOTP)
        UserDefaults.standard.synchronize()
    }
    
    func shouldShowOTP() ->Bool {
//        if let _ = UserDefaults.standard.object(forKey: savedOTP){
//            return true
//        }
        if let isOtpverified = self.getLoggedInUser()?.isOTPVerified{
            return !isOtpverified
        }
        return false
    }
    
    func removeOTPForTheUser() {
        
        if let _ =  UserDefaults.standard.object(forKey: savedOTP) {
            UserDefaults.standard.removeObject(forKey: savedOTP)
        }
    }
    
    func getSavedOTP() -> String?{
        
        if let accessToken:String = UserDefaults.standard.object(forKey: savedOTP) as! String? {
            return accessToken
        } else {
            return ""
        }
    }
}
