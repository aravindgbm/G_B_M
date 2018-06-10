    //
    //  LIVideoModel.swift
    //  LearnsersIndia
    //
    //  Created by GB Mainframe LLP on 09/06/18.
    //  Copyright © 2018 macbook. All rights reserved.
    //
    
    import UIKit
    
    class LIVideoModel: NSObject {
        var videoPrivateUrl:String?
        var subjectId:Int?
        var subjectName:String?
        var topicName:String?
        var videoCategory:String?
        var videoDiscription:String?
        var videoTitle:String?
        var videoId:Int?
        var videoUrl:String?
        var videoThumbnailUrl:String?
        //    "" = "<null>";
        //    "sub_id" = 1;
        //     = Maths;
        //    "syl_id" = 1;
        //     = "Euclid's Division Lemma";
        //    "ved_category" = free;
        //    "" = "Class 10\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\nChapter 1\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\nReal Numbers";
        //    "" = 253;
        //    "ved_tags" = "Real Numbers,Class 10 Chapter 1,Euclid\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\'s division algorithm";
        //    "" = "Euclid\\'s division algorithm";
        //    "ved_type" = vimeo;
        //    "ved_url" = "https://vimeo.com/265716071";
        //    "video_id" = "";
        //    "video_image" = "http://i.vimeocdn.com/video/695797588_640.jpg";
        
        convenience init?(_ response:[String:Any]?) {
            self.init()
            if let _ = response {
                if let privateUrl =  response?["private_url"] as? String {
                    self.videoPrivateUrl = privateUrl
                    self.subjectId = response?["sub_id"] as? Int
                    self.subjectName = response?["subjectname"] as? String
                    self.topicName = response?["topicname"] as? String
                    self.videoCategory = response?["ved_category"] as? String
                    self.videoDiscription = response?["ved_desc"] as? String
                    self.videoTitle = response?["ved_title"] as? String
                    self.videoId = response?["ved_id"] as? Int
                    self.videoUrl = response?["ved_url"] as? String
                    self.videoThumbnailUrl = response?["video_image"] as? String
                }
                else {
                    return nil
                }
            }
            else {
                return nil
            }
        }
        override init() {
            super.init()
        }
    }
