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
        @escaping (([String:AnyObject]?) -> Void),failure: @escaping (([String:AnyObject]?) ->Void), error:@escaping ((Error)?) ->Void) {
        LIAPIClient.sharedInstance.callRequest(requestParams, httpMethod: .get, shouldAddParams: false, urlString: LIAPIURL.getBoardURL, shouldAddHeaderParams: false, successBlock: { (response) in
            success(response)
        }, failureBlock: { (response) in
            failure(response)
        }) { (err) in
            error(err)
        }
    }
}
