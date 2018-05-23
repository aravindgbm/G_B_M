//
//  LIAPIConstants.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 20/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIAPIConstants: NSObject {
static let sharedInstance = LIAPIConstants()
}
public let HTTP_STATUS_OK              = 200
public let HTTP_STATUS_UNASSIGNED      = 299
public let HTTP_STATUS_UNAUTHORIZED    = 401
public let HTTP_STATUS_BAD_REQUEST     = 400
//public let LIBaseUrlString = "https://appapi.learnersindia.com/"
public let LIBaseUrlString = "http://apistaging.learnersindia.com/"

struct LIAPIURL{
    static let signUpURL = "signup"
    static let loginInURL = ""
    static let forgotPasswordURL = ""
    static let logOutURL = ""
    static let getBoardURL = "get-board"
    static let getClassURL = "get-class"
}

struct LIAPIResponseKeys {
    static let responseCode = "response_code"
    static let responseData = "response_data"
    static let responseType = "response_type"
    static let responseText = "response_text"
}
