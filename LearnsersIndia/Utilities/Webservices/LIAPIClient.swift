//
//  LIAPIClient.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 20/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire
class LIAPIClient: NSObject {
    
    static let sharedInstance = LIAPIClient()
    let headerContentTypeKey = "Content-Type"
    let headerContentTypeValue = "application/json"
    let headerAuthorisationKey = "Authorization"
    let tokenKey = "tocken "
    
    
    func getRequestHeaders() -> Dictionary <String,String>? {
        
        var header:Dictionary = [headerContentTypeKey:headerContentTypeValue]
        
//        let headerAuthorisationValue = tokenKey + SPAuthorizationManager.sharedInstance.getAccesToken()!
//        header.updateValue(headerAuthorisationValue, forKey: headerAuthorisationKey)
        return header
    }
    
    func callRequest(_ requestParams:[String:AnyObject]?, httpMethod:HTTPMethod, shouldAddParams:Bool,urlString:String,shouldAddHeaderParams:Bool, successBlock:
        (([String:AnyObject]?) -> Void)?,failureBlock: (([String:AnyObject]?) ->Void)?, errorBlock:@escaping ((Error)?) ->Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var webServiceURLString:String = ""
        var requestHeader = Dictionary<String,String>()
        if urlString.isEmpty{
            webServiceURLString = LIBaseUrlString
        } else{
            webServiceURLString = LIBaseUrlString + urlString
        }
        
        if shouldAddHeaderParams {
            requestHeader = getRequestHeaders()!
        }
//        if shouldAddParams == true {
//            requestParams = (apiRequest.toDictionary())
//        } else {
//            requestParams = nil
//        }
        
        debugPrint("Request Url - \(webServiceURLString)")
        if requestParams != nil {
            debugPrint("Params - \(requestParams!)")
        }
        
        debugPrint("header - \(requestHeader)")
        let webServiceURL = URL(string: webServiceURLString)
        if webServiceURL == nil {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            SPUtilities.showOkAlertControllerWith("", message: NSLocalizedString("ERROR_OCCURRED", comment: ""), onViewController: (AppDelegate.getAppDelegateInstance().window?.rootViewController)!)
            return
        }
        request(webServiceURL!, method: httpMethod, parameters: requestParams, encoding: JSONEncoding.default, headers: requestHeader).responseJSON { (response:DataResponse) in
            
            debugPrint("Printing Response- \n",response)
            debugPrint("Printing Requst- \n",response.request?.httpBody ?? "")
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if response.result.isSuccess {
                
                if let responseArray = response.result.value as? [[String:AnyObject]] {
                    print("\(responseArray)")
                }
                if let responseData = response.result.value as? [String:AnyObject],let responseStatusCode = response.response?.statusCode {
                    if responseStatusCode >= HTTP_STATUS_OK && responseStatusCode <= HTTP_STATUS_UNASSIGNED {
                        
                        if let responseDict = responseData as [String:AnyObject]? {
                            if responseDict[LIAPIResponseKeys.responseType] as? String == "error" {
                                failureBlock!(responseDict)
                            }
                            else {
                                successBlock!(responseDict)
                            }
                        }
                        
                    }
                        
                    else {
                        if responseStatusCode == HTTP_STATUS_UNAUTHORIZED {
//                            SVProgressHUD.dismiss()
//                            let appdelegate = AppDelegate.getAppDelegateInstance()
//                            SPAuthorizationManager.sharedInstance.removeLoggedInUserAndToken()
//                            appdelegate.checkLoginStatusAndNavigateToScreens()
//                            SPUtilities.showOkAlertControllerWith("", message: "Sorry your login session has expired please login to continue", onViewController: (AppDelegate.getAppDelegateInstance().window?.rootViewController)!)
                            return
                        }
                        else if responseStatusCode == HTTP_STATUS_BAD_REQUEST {
//                            SVProgressHUD.dismiss()
                            if let error = responseData["error"] as? [String:AnyObject] {
//                                let errorObject = SPAPIErrorObject(dictionary: error)
//                                SPUtilities.showOkAlertControllerWith("Oops!", message: errorObject?.message, onViewController: (AppDelegate.getAppDelegateInstance().window?.rootViewController)!)
                            }
                            
                            
                        }
                        
                    }
                }
                
            }
                
            else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let error = response.result.error {
                    errorBlock(error)
                    debugPrint("Error --- \n",error.localizedDescription)
                }
            }
            
        }
        
    }
    
}
