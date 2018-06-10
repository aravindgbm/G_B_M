//
//  LIQuestionsModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 10/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIQuestionsModel: NSObject {
    var questionTitle:NSAttributedString?
    var totalAnswerCount:Int?
    var studentProfilPicUrl:String?
    var questionId:Int?
    var questionTimeStamp:String?
    var studentName:String?
    var subjectName:String?
    
    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        if  let htmlQuestionTitle = response["qst_title"] as? String{
            if let questionText = self.getQuestionTitleWithHtmlString(htmlQuestionTitle) {
                self.questionTitle = questionText
                self.totalAnswerCount = response["Total_answers"] as? Int
                self.studentProfilPicUrl = LIImageBaseUrlString + (response["profile_pic"] as? String ?? "")
                self.questionId = response["qst_id"] as? Int
                self.questionTimeStamp = response["qst_timestamp"] as? String
                self.studentName = response["student"] as? String
                self.subjectName = response["subjectname"] as? String
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
        
    }
    
    func getQuestionTitleWithHtmlString( _ htmlString:String) -> NSAttributedString?{
        if let htmlData = htmlString.data(using: String.Encoding.unicode) {
            do {
               return try NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            } catch let e as NSError {
                print("Couldn't translate \(htmlString): \(e.localizedDescription) ")
                return nil
            }
        }
        return nil
    }
}
