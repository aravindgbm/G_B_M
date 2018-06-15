//
//  LITopicModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 13/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LITopicModel: NSObject {
    var topicId:Int?
    var topicName:String?
    var videoArray:[LIVideoModel]?
//    "": 63,
//    "": "Classification of polygons",
    
    override init() {
        super.init()
    }
    
    convenience init?(_ response:[String:Any]){
        self.init()
        self.topicId = response["topic_id"] as? Int
        self.topicName = response["topic_name"] as? String
//        var videoArray:Array<LIVideoModel> = Array()
        if let videoArray = response[LIAPIResponseKeys.videoData] as? [[String:AnyObject]]{
            for object in videoArray {
                if let videoObject = LIVideoModel(object) {
                    if self.videoArray == nil {
                        self.videoArray = [LIVideoModel]()
                    }
                    self.videoArray?.append(videoObject)
                }
            }
        }
        else {
            return nil
        }
        if self.videoArray == nil {
            return nil
        }
    }
}
