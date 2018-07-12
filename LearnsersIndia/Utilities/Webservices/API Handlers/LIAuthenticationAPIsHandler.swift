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
                else{
                    success(nil)
                }
                
            }
            else {
                success(nil)
            }
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
                else{
                    success(nil)
                }
                
            }
            else {
                success(nil)
            }
            
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
            var status = false
            if let responseDict = response {
                if let userData = responseDict["user_data"] as? [String:AnyObject] {
                    let loggedInUser = LIUserModel(userData)
//                if let _ = responseDict["user_id"] as? String {
//                    let loggedInUser = LIUserModel(responseDict)
//                    loggedInUser.userId = userId
//                    loggedInUser.email = responseDict["email"] as? String
//                    loggedInUser.mobileNumber = responseDict["mobile"] as? String
                    loggedInUser?.isOTPVerified = false
//                    loggedInUser.fullName = requestParams!["fullname"] as? String
                    LIAccountManager.sharedInstance.setLoggedInUser(loggedInUser)
                    if let token = userData["tocken"] as? String{
                        LIAccountManager.sharedInstance.setAccessToken(token)
                    }
                    if let otp = userData["verification_key"] as? String{
                        LIAccountManager.sharedInstance.saveOTPForTheUser(otp)
                    }
                    status = true
                }
            }
            success(status)

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
            var status = false
            if let responseDict = response {
                if let userData = responseDict["user_data"] as? [String:AnyObject] {
                    let loggedInUser = LIUserModel(userData)
////                    loggedInUser.userId = userId
//                    loggedInUser.email = userData["email_id"] as? String
//                    loggedInUser.mobileNumber = userData["phoneno"] as? String
//                    loggedInUser.fullName = userData["full_name"] as? String
//                    loggedInUser.classId = userData["cls_id"] as? NSNumber
//                    loggedInUser.gradeName = userData["gradename"] as? String
//                    loggedInUser.syllabusId = userData["syl_id"] as? NSNumber
//                    if let otpVerificationStatus = userData["verified"] as? Int{
//                        loggedInUser.isOTPVerified = otpVerificationStatus == 1
//                    }
//                    if let paymentStatus = userData["paidstatus"] as? String {
//                        loggedInUser.isPaidUser = paymentStatus == LIConstants.paidUserStatus
//                    }
                    LIAccountManager.sharedInstance.setLoggedInUser(loggedInUser)
                    if let token = userData["tocken"] as? String{
                        LIAccountManager.sharedInstance.setAccessToken(token)
                    }
                    if let otp = responseDict["verification_key"] as? String{
                        LIAccountManager.sharedInstance.saveOTPForTheUser(otp)
                    }
                    status = true
                    }
                }
            success (status)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
        
    }
    
    class func callValidateOTPAPIWith(_ requestParams:[String:AnyObject]?,success:
        @escaping ((Bool) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .post, shouldAddParams: true, urlString: LIAPIURL.validateOTP, shouldAddHeaderParams: false, successBlock: { (response) in
            var status = false
            if let responseDict = response {
                if let responseType = responseDict[LIAPIResponseKeys.responseType] as? String{
                    if responseType == "success" {
                        LIAccountManager.sharedInstance.removeOTPForTheUser()
                        let loggedInUser = LIAccountManager.sharedInstance.getLoggedInUser()
                        loggedInUser?.isOTPVerified = true
                        LIAccountManager.sharedInstance.setLoggedInUser(loggedInUser)
                        status = true
                    }
                }
                
            }
            success(status)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
    }
    
    class func callResendOTPAPIWith(_ requestParams:[String:AnyObject]?,success:
        @escaping  ((Bool) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .post, shouldAddParams: true, urlString: LIAPIURL.resendOTP, shouldAddHeaderParams: false, successBlock: { (response) in
            var status = false
            if let reponseDict = response {
                if let otp = reponseDict["otp"] as? String {
                      LIAccountManager.sharedInstance.saveOTPForTheUser(otp)
                    status = true
                }
            }
            success(status)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
    }
    
    class func callSendOTPForPasswordRecoveryAPIWith(_ requestParams:[String:AnyObject]?,success:
        @escaping ((Bool) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .post, shouldAddParams: true, urlString: LIAPIURL.sendOTPForPasswordRecoveryURL, shouldAddHeaderParams: false, successBlock: { (response) in
            var status = false
            if let responseDict = response {
                if let responseType = responseDict[LIAPIResponseKeys.responseType] as? String{
                    if responseType == "success" {
                        if let token = responseDict["tocken"] as? String{
                            LIAccountManager.sharedInstance.setAccessToken(token)
                        }
                        status = true
                    }
                }
                
            }
            success(status)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
    }
    
    class func callValidateOTPForPasswordRecoveryAPIWith(_ requestParams:[String:AnyObject]?,success:
        @escaping ((Bool) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .post, shouldAddParams: true, urlString: LIAPIURL.validateOTPForPasswordRecoveryURL, shouldAddHeaderParams: false, successBlock: { (response) in
            var status = false
            if let responseDict = response {
                if let responseType = responseDict[LIAPIResponseKeys.responseType] as? String{
                    if responseType == "success" {
                        if let token = responseDict["tocken"] as? String{
                            LIAccountManager.sharedInstance.setAccessToken(token)
                        }
                        status = true
                    }
                }
                
            }
            success(status)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
    }
    
    class func callResetForPasswordAPIWith(_ requestParams:[String:AnyObject]?,success:
        @escaping ((Bool) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .post, shouldAddParams: true, urlString: LIAPIURL.resetPasswordURL, shouldAddHeaderParams: false, successBlock: { (response) in
            var status = false
            if let responseDict = response {
                if let responseType = responseDict[LIAPIResponseKeys.responseType] as? String{
                    if responseType == "success" {
                        if let token = responseDict["tocken"] as? String{
                            LIAccountManager.sharedInstance.setAccessToken(token)
                        }
                        status = true
                    }
                }
                
            }
            success(status)
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
    }

}
