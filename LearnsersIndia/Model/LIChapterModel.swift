//
//  LIChapterModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 13/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIChapterModel: NSObject {
    var boardName:String?
    var chapterName:String?
    var chapterId:Int?
    var classId:Int?
    var gradeName:String?
    var subjectId:Int?
    var sylabusId:Int?


    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        self.boardName = response["boardname"] as? String
        self.chapterName = response["chapter"] as? String
        self.chapterId = response["chp_id"] as? Int
        self.classId = response["cls_id"] as? Int
        self.gradeName = response["gradename"] as? String
        self.subjectId = response["sub_id"] as? Int
        self.sylabusId = response["syl_id"] as? Int
    }
    
}

