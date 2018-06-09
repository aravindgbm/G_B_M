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
        @escaping (([[String:AnyObject]]?) -> Void),failure: @escaping ((String?) ->Void), error:@escaping ((Error)?) ->Void) {
        var request = requestParams
        if shouldAddToken && requestParams != nil{
            request![LIAPIRequestKeys.token] = LIAccountManager.sharedInstance.getAccesToken()
        }
        LIAPIClient.sharedInstance.callRequest(request, httpMethod: .get, shouldAddParams: true, urlString: LIAPIURL.getDemoVideosURL, shouldAddHeaderParams: false, successBlock: { (response) in
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
}
