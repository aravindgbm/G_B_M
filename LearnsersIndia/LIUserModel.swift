//
//  LIUserModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 23/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIUserModel: NSObject,NSCoding {
    var fullName:String?
    var email:String?
    var userId : NSNumber?
    var mobileNumber:String?
    
    required override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fullName = aDecoder.decodeObject(forKey: "fullName") as! String?
        email = aDecoder.decodeObject(forKey: "email") as! String?
        userId = aDecoder.decodeObject(forKey: "userId") as! NSNumber?
        mobileNumber = aDecoder.decodeObject(forKey: "mobile") as! String?
        
    }
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(fullName, forKey: "fullName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(mobileNumber, forKey: "mobile")
    }
    
}
