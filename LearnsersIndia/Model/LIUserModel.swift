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
    var userId : String?
    var mobileNumber: String?
    var isOTPVerified: Bool?
    var isPaidUser: Bool?
    var classId: NSNumber?
    var gradeName: String?
    var syllabusId: NSNumber?
    var address:String?
    var boardName:String?
    var cityName:String?
    var countryName:String?
    var dateOfBirth:String?
    var gender:String?
    var phonenumber:String?
    var profilePicUrl:String?
    var stateName:String?
    var studentId:NSNumber?
    var subjectId:NSNumber? = 1
    
    required override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fullName = aDecoder.decodeObject(forKey: "fullName") as! String?
        email = aDecoder.decodeObject(forKey: "email") as! String?
        userId = aDecoder.decodeObject(forKey: "userId") as! String?
        mobileNumber = aDecoder.decodeObject(forKey: "mobile") as! String?
        isOTPVerified = aDecoder.decodeObject(forKey: "isOTPVerified") as! Bool?//decodeBool(forKey: "isOTPVerified")
        isPaidUser = aDecoder.decodeObject(forKey: "isPaidUser") as! Bool?
        classId = aDecoder.decodeObject(forKey: "classId") as! NSNumber?
        gradeName = aDecoder.decodeObject(forKey: "gradeName") as! String?
        syllabusId = aDecoder.decodeObject(forKey: "syllabusId") as! NSNumber?
        address = aDecoder.decodeObject(forKey: "address") as! String?
        boardName = aDecoder.decodeObject(forKey: "boardName")as! String?
        cityName = aDecoder.decodeObject(forKey: "cityName") as! String?
        countryName = aDecoder.decodeObject(forKey: "countryName") as! String?
        dateOfBirth = aDecoder.decodeObject(forKey: "dateOfBirth") as! String?
        gender = aDecoder.decodeObject(forKey: "gender") as! String?
        phonenumber = aDecoder.decodeObject(forKey: "phonenumber") as! String?
        profilePicUrl = aDecoder.decodeObject(forKey: "profilePicUrl") as! String?
        stateName = aDecoder.decodeObject(forKey: "stateName") as! String?
        studentId = aDecoder.decodeObject(forKey: "studentId") as! NSNumber?
        subjectId = aDecoder.decodeObject(forKey: "subjectId") as! NSNumber?
        
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
        aCoder.encode(address, forKey: "address")
        aCoder.encode(boardName, forKey: "boardName")
        aCoder.encode(cityName, forKey: "cityName")
        aCoder.encode(countryName, forKey: "countryName")
        aCoder.encode(dateOfBirth, forKey: "dateOfBirth")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(phonenumber, forKey: "phonenumber")
        aCoder.encode(profilePicUrl, forKey: "profilePicUrl")
        aCoder.encode(stateName, forKey: "stateName")
        aCoder.encode(studentId, forKey: "studentId")
        aCoder.encode(subjectId, forKey: "subjectId")
    }
    
    func updateUserObjectWith(_ response:[String:Any]) {
        self.classId = response["cls_id"] as? NSNumber
        self.email = response["email_id"] as? String
        self.fullName = response["full_name"] as? String
        self.gradeName = response["gradename"] as? String
        self.syllabusId = response["syl_id"] as? NSNumber
        self.address = response["address"] as? String
        self.boardName = response["boardname"] as? String
        self.cityName = response["city"] as? String
        self.countryName = response["country"] as? String
        self.dateOfBirth = response["dob"] as? String
        self.gender = response["gender"] as? String
        self.phonenumber = response["phoneno"] as? String
        if let profilePic = response["profile_pic"] as? String {
            self.profilePicUrl = profilePic + LIImageBaseUrlString
        }
        self.stateName = response["state"] as? String
        self.studentId = response ["std_id"] as? NSNumber
    }
    convenience init?(_ response:[String:Any]) {
    self.init()
    self.userId = response["user_id"] as? String
    self.email = response["email_id"] as? String
    self.mobileNumber = response["phoneno"] as? String
    self.fullName = response["full_name"] as? String
    self.classId = response["cls_id"] as? NSNumber
    self.gradeName = response["gradename"] as? String
    self.syllabusId = response["syl_id"] as? NSNumber
    if let otpVerificationStatus = response["verified"] as? Int{
        self.isOTPVerified = otpVerificationStatus == 1
    }
    if let paymentStatus = response["paidstatus"] as? String {
        self.isPaidUser = paymentStatus == LIConstants.paidUserStatus
    }
    }
}
