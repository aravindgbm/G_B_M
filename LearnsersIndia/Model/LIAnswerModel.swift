//
//  LIAnswerModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 24/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIAnswerModel: NSObject {
    
    var answer:String?
    var userProfilPicUrl:String?
    var answerTimeStamp:Int?
    var userName:String?
    var answerImage:String?
    
    
    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
                self.answer = response["qst_answer"] as? String
                self.userProfilPicUrl = LIImageBaseUrlString + (response["asw_profile_pic"] as? String ?? "")
                self.answerTimeStamp = response["asw_timestamp"] as? Int
                self.userName = response["full_name"] as? String
                self.answerImage =  LIImageBaseUrlString + (response["asw_image"] as? String ?? "")
    }
}
