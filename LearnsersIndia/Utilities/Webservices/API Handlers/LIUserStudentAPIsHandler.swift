//
//  LIStudentLoginAPIsHandler.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 09/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIUserStudentAPIsHandler: NSObject {
    
    class func callGetDemoVideosAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping ((Array<LIVideoModel>?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getDemoVideosURL, shouldAddHeaderParams: false, successBlock: { (response) in
            if let reponseDict = response {
                if let responseArray = reponseDict[LIAPIResponseKeys.videoData] as? [[String:AnyObject]] {
                    var videoArray:Array<LIVideoModel> = Array()
                    for object in responseArray {
                        if let videoObject = LIVideoModel(object) {
                            videoArray.append(videoObject)
                        }
                    }
                    success(videoArray)
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
    
    class func callGetRecommendedQuestionsAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping ((Array<LIQuestionsModel>?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getRecommendedQuestionsURL, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if let responseArray = responseDict[LIAPIResponseKeys.questionsData] as? [[String:AnyObject]] {
                    var questionsArray:Array<LIQuestionsModel> = Array()
                    for object in responseArray {
                        if let videoObject = LIQuestionsModel(object) {
                            questionsArray.append(videoObject)
                        }
                    }
                    success(questionsArray)
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
   
    class func callGetPaidStatusAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping (() -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        else if (shouldAddToken) {
            request = [String:Any]()
            request?[LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.checkPaidStatus, shouldAddHeaderParams: false, successBlock: { (response) in
            if let reponseDict = response {
                if let paymentStatus = reponseDict["payment_status"] as? String {
                    let loggedInUser = LIAccountManager.sharedInstance.getLoggedInUser()
                    loggedInUser?.isPaidUser = paymentStatus == LIConstants.paidUserStatus
                    LIAccountManager.sharedInstance.setLoggedInUser(loggedInUser)
                }
            }
            success()
        }, failureBlock: { (response) in
            if let responseDict = response {
                failure(responseDict[LIAPIResponseKeys.responseText] as? String)
            }
        }) { (err) in
            error(err)
        }
    }
    
    class func callGetUserProfileAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping ((LIUserModel?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getUserProfile, shouldAddHeaderParams: false, successBlock: { (response) in
            if let reponseDict = response {
                if let userData = reponseDict[LIAPIResponseKeys.userData] as? [String:AnyObject] {
                    let loggedInUser = LIAccountManager.sharedInstance.getLoggedInUser()
                    loggedInUser?.updateUserObjectWith(userData)
                    LIAccountManager.sharedInstance.setLoggedInUser(loggedInUser)
                    success(loggedInUser)
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
    
    
    class func callGetChaptersAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping (([String:Any]?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getChaptersUrl, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if let responseArray = responseDict[LIAPIResponseKeys.chaptersData] as? [[String:AnyObject]] {
//                    var questionsArray:Array<LIQuestionsModel> = Array()
//                    for object in responseArray {
//                        if let videoObject = LIQuestionsModel(object) {
//                            questionsArray.append(videoObject)
//                        }
//                    }
                    success(responseDict)
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
}
