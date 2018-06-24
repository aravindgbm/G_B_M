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
                        if let questionObject = LIQuestionsModel(object) {
                            questionsArray.append(questionObject)
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
        @escaping ((Array<LIChapterModel>?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getChaptersUrl, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if let responseArray = responseDict[LIAPIResponseKeys.chaptersData] as? [[String:Any]] {
                    var chaptersArray:Array<LIChapterModel> = Array()
                    for object in responseArray {
                      
                        if let chapterObject = LIChapterModel(object) {
                            chaptersArray.append(chapterObject)
                        }
                    }
                    success(chaptersArray)
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
    
    
    class func callGetVideosAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping ((Array<LITopicModel>?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getVideosUrl, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if let responseArray = responseDict[LIAPIResponseKeys.responseData] as? [[String:Any]] {
                    var topicsArray:Array<LITopicModel> = Array()
                    for object in responseArray {
                        
                        if let topicObject = LITopicModel(object) {
                            topicsArray.append(topicObject)
                        }
                    }
                    success(topicsArray)
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
    
    class func callGetExercisesAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping ((Array<LITopicModel>?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getExercisesUrl, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if let responseArray = responseDict[LIAPIResponseKeys.responseData] as? [[String:Any]] {
                    var topicsArray:Array<LITopicModel> = Array()
                    for object in responseArray {
                        
                        if let topicObject = LITopicModel(object) {
                            topicsArray.append(topicObject)
                        }
                    }
                    success(topicsArray)
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
    
    class func callGetTestQuestionsAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping ((Array<LITestModel>?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getTestQuestionsUrl, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if let responseArray = responseDict[LIAPIResponseKeys.responseData] as? [[String:Any]] {
                    var testDetailsArray:Array<LITestModel> = Array()
                    for object in responseArray {
                        
                        if let testObject = LITestModel(object) {
                            testDetailsArray.append(testObject)
                        }
                    }
                    success(testDetailsArray)
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
    
    class func callGetGameLevelsAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping ((Array<LIGameLevelModel>?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        else if shouldAddToken && requestParams == nil {
            request = [String:Any]()
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getGameLevelUrl, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if let responseArray = responseDict[LIAPIResponseKeys.responseData] as? [[String:Any]] {
                    var gameLevelsArray:Array<LIGameLevelModel> = Array()
                    for object in responseArray {
                        
                        if let levelObject = LIGameLevelModel(object) {
                            gameLevelsArray.append(levelObject)
                        }
                    }
                    success(gameLevelsArray)
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
    
    class func callGetGameQuestionAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping ((LIGameModel?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getGameQuestionUrl, shouldAddHeaderParams: false, successBlock: { (response) in
            if let reponseDict = response {
                if let gameData = reponseDict[LIAPIResponseKeys.questionData] as? [String:AnyObject] {
                    let gameObject = LIGameModel(gameData)
                    success(gameObject)
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
    
    class func callAskQuestionAPIWith(_ requestParams:[String:Any]?,shouldAddToken:Bool,success:
        @escaping ((Bool) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        else if (shouldAddToken) {
            request = [String:Any]()
            request?[LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.askQuestionUrl, shouldAddHeaderParams: false, successBlock: { (response) in
            if let responseDict = response {
                if responseDict[LIAPIResponseKeys.responseType] as? String == LIAPIResponse.sucessResponse {
                    success(true)
                }
                else {
                     success(false)
                }
            }
            else {
                success(false)
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
