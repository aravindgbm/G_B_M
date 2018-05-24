//
//  LIAuthorizationAPIsHandler.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 22/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIAuthenticationAPIsHandler: NSObject {
//class func callSignUpAPIWith(_ request:SPEmailSignUpRequestModel,sucess:((Void) -> Void)?,failure:((Error?) -> Void)?) {
//    }
    class func callGetBoardAPIWith(_ requestParams:[String:AnyObject]?,success:
        @escaping (([[String:AnyObject]]?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .get, shouldAddParams: false, urlString: LIAPIURL.getBoardURL, shouldAddHeaderParams: false, successBlock: { (response) in
            if let reponseDict = response {
                if let responseArray = reponseDict[LIAPIResponseKeys.responseData] as? [[String:AnyObject]] {
                    success(responseArray)
                }
                
            }
            success(nil)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
    }
    
    class func callGetClassAPIWith(_ requestParams:[String:AnyObject]?,success:
        @escaping (([[String:AnyObject]]?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .get, shouldAddParams: false, urlString: LIAPIURL.getClassURL, shouldAddHeaderParams: false, successBlock: { (response) in
            if let reponseDict = response {
                if let responseArray = reponseDict[LIAPIResponseKeys.responseData] as? [[String:AnyObject]] {
                    success(responseArray)
                }
                
            }
            success(nil)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
    }

    class func callSignUpAPIWith(_ requestParams:[String:AnyObject]?,success:
        @escaping ((Bool) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .post, shouldAddParams: true, urlString: LIAPIURL.signUpURL, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if let userId = responseDict["user_id"] as? NSNumber {
                    let loggedInUser = LIUserModel()
                    loggedInUser.userId = userId
                    loggedInUser.email = responseDict["email"] as? String
                    loggedInUser.mobileNumber = responseDict["mobile"] as? String
//                    loggedInUser.fullName = requestParams!["fullname"] as? String
                    LIAccountManager.sharedInstance.setLoggedInUser(loggedInUser)
                    if let token = responseDict["tocken"] as? String{
                        LIAccountManager.sharedInstance.setAccessToken(token)
                    }
                    if let otp = responseDict["otp"] as? Int{
                        LIAccountManager.sharedInstance.saveOTPForTheUser(otp)
                    }
                    success(true)
                }
                
//                if let responseArray = reponseDict[LIAPIResponseKeys.responseData] as? [[String:AnyObject]] {
//                    success(responseArray)
//                }
                
            }
            success (false)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
        
    }
    class func callSignInAPIWith(_ requestParams:[String:AnyObject]?,success:
        @escaping ((Bool) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .post, shouldAddParams: true, urlString: LIAPIURL.signInURL, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if let userId = responseDict["user_id"] as? NSNumber {
//                    let loggedInUser = LIUserModel()
//                    loggedInUser.userId = userId
//                    loggedInUser.email = responseDict["email"] as? String
//                    loggedInUser.mobileNumber = responseDict["mobile"] as? String
//                    //                    loggedInUser.fullName = requestParams!["fullname"] as? String
//                    LIAccountManager.sharedInstance.setLoggedInUser(loggedInUser)
                    if let token = responseDict["tocken"] as? String{
                        LIAccountManager.sharedInstance.setAccessToken(token)
                    }
                    if let otp = responseDict["otp"] as? Int{
                        LIAccountManager.sharedInstance.saveOTPForTheUser(otp)
                    }
                    success(true)
                }
                
                //                if let responseArray = reponseDict[LIAPIResponseKeys.responseData] as? [[String:AnyObject]] {
                //                    success(responseArray)
                //                }
                
            }
            success (false)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
        
    }
}
