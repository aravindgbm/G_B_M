//
//  LIGameModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 23/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIGameModel: NSObject {
    var gameQuestionId:Int?
//    var gameQuestionHTMLString:String = ""
    var optionsArray:[LIAnswerOptionModel]?
    var correctOptionId:Int?
    var gameQuestionString:NSAttributedString?
    var levelDuration:Int?
    var firstAudioUrl:String?
    var secondAudioUrl:String?
    
    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        if let questionId = response["question_id"] as? Int {
            self.gameQuestionId = questionId
        }
        else{
            return nil
        }
        if  let gameQuestionHTMLString = response["question"] as? String {
            if let gameQuestionString = LIUtilities.getAttributedStringFromHtmlString(gameQuestionHTMLString) {
                self.gameQuestionString = gameQuestionString
            }
            else {
                return nil
            }
        }
        else{
            return nil
        }
        if let _ = response["answer"] as? Int {
            self.correctOptionId = response["answer"] as? Int
        }
        else {
            return nil
        }
        self.optionsArray = [LIAnswerOptionModel]()
        if let option1 = response["option1"] as? String {
            
            let option = LIAnswerOptionModel(LIAnswerOptionId.option1, option: option1)
            let isOptionCorrect = self.correctOptionId != nil && self.correctOptionId == option.optionId?.rawValue
            option.isCorrectOption = isOptionCorrect
            option.convertHTMLStringsToAttributedStrings()
            self.optionsArray?.append(option)
        }
        
        if let option2 = response["option2"] as? String {
            let option = LIAnswerOptionModel(LIAnswerOptionId.option2, option: option2)
            let isOptionCorrect = self.correctOptionId != nil && self.correctOptionId == option.optionId?.rawValue
            option.isCorrectOption = isOptionCorrect
            option.convertHTMLStringsToAttributedStrings()
            self.optionsArray?.append(option)
        }
        
        if let option3 = response["option3"] as? String {
            let option = LIAnswerOptionModel(LIAnswerOptionId.option3, option: option3)
            let isOptionCorrect = self.correctOptionId != nil && self.correctOptionId == option.optionId?.rawValue
            option.isCorrectOption = isOptionCorrect
            option.convertHTMLStringsToAttributedStrings()
            self.optionsArray?.append(option)
        }
        if let option4 = response["option4"] as? String {
            let option = LIAnswerOptionModel(LIAnswerOptionId.option4, option: option4)
            let isOptionCorrect = self.correctOptionId != nil && self.correctOptionId == option.optionId?.rawValue
            option.isCorrectOption = isOptionCorrect
            option.convertHTMLStringsToAttributedStrings()
            self.optionsArray?.append(option)
        }
        if optionsArray?.count == 0 {
            return nil
        }
        self.levelDuration = response["duration"] as? Int
        if let audioUrl =  response["voice1"] as? String{
            self.firstAudioUrl = LIImageBaseUrlString + audioUrl
        }
        if let audioUrl = response["voice2"] as? String {
            self.secondAudioUrl = LIImageBaseUrlString + audioUrl
        }
    }
    
}
