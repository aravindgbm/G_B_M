//
//  LIUserModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 23/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIUserModel: NSObject,NSCoding {
    var fullName: String?
    var email: String?
    var userId : NSNumber?
    var mobileNumber: String?
    var isOTPVerified: Bool?
    var isPaidUser: Bool?
    var classId: NSNumber?
    var gradeName: String?
    var syllabusId: NSNumber?
    
    required override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fullName = aDecoder.decodeObject(forKey: "fullName") as! String?
        email = aDecoder.decodeObject(forKey: "email") as! String?
        userId = aDecoder.decodeObject(forKey: "userId") as! NSNumber?
        mobileNumber = aDecoder.decodeObject(forKey: "mobile") as! String?
        isOTPVerified = aDecoder.decodeObject(forKey: "isOTPVerified") as! Bool?//decodeBool(forKey: "isOTPVerified")
        isPaidUser = aDecoder.decodeObject(forKey: "isPaidUser") as! Bool?
        classId = aDecoder.decodeObject(forKey: "classId") as! NSNumber?
        gradeName = aDecoder.decodeObject(forKey: "gradeName") as! String?
        syllabusId = aDecoder.decodeObject(forKey: "syllabusId") as! NSNumber?
        
    }
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(fullName, forKey: "fullName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(mobileNumber, forKey: "mobile")
        aCoder.encode(isOTPVerified, forKey: "isOTPVerified")
        aCoder.encode(isPaidUser, forKey: "isPaidUser")
        aCoder.encode(classId, forKey: "classId")
        aCoder.encode(gradeName, forKey: "gradeName")
        aCoder.encode(syllabusId, forKey: "syllabusId")
    }
    
}
