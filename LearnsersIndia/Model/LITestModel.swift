//
//  LITestModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LITestModel: NSObject {
    
    var orderNumber:Int?
    var testQuestionId:Int?
    var testQuestionHTMLString:String = ""
    var optionsArray:[LIAnswerOptionModel]?
    var correctOptionId:Int?
    var markString:String?
    var solutionHTMLString:String?
    var solutionString:NSAttributedString?
    var testQuestionString:NSAttributedString?


    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        if let _ = response["order_number"] as? Int {
            self.orderNumber = response["order_number"] as? Int
        }
        else{
            return nil
        }
        self.testQuestionId = response["test_question_id"] as? Int
        if let question =  response["test_question"] as? String{
            self.testQuestionHTMLString = question
        }
        else {
            return nil
        }
        if let _ = response["correct_answer"] as? Int {
            self.correctOptionId = response["correct_answer"] as? Int
        }
        else {
            return nil
        }
        self.optionsArray = [LIAnswerOptionModel]()
        if let option1 = response["option1"] as? String {
        
            let option = LIAnswerOptionModel(LIAnswerOptionId.option1, option: option1)
            let isOptionCorrect = self.correctOptionId != nil && self.correctOptionId == option.optionId?.rawValue
            option.isCorrectOption = isOptionCorrect
            self.optionsArray?.append(option)
        }
        
        if let option2 = response["option2"] as? String {
            let option = LIAnswerOptionModel(LIAnswerOptionId.option2, option: option2)
            let isOptionCorrect = self.correctOptionId != nil && self.correctOptionId == option.optionId?.rawValue
            option.isCorrectOption = isOptionCorrect
            self.optionsArray?.append(option)
        }
        
        if let option3 = response["option3"] as? String {
            let option = LIAnswerOptionModel(LIAnswerOptionId.option3, option: option3)
            let isOptionCorrect = self.correctOptionId != nil && self.correctOptionId == option.optionId?.rawValue
            option.isCorrectOption = isOptionCorrect
            self.optionsArray?.append(option)
        }
        if let option4 = response["option4"] as? String {
            let option = LIAnswerOptionModel(LIAnswerOptionId.option4, option: option4)
            let isOptionCorrect = self.correctOptionId != nil && self.correctOptionId == option.optionId?.rawValue
            option.isCorrectOption = isOptionCorrect
            self.optionsArray?.append(option)
        }
        if optionsArray?.count == 0 {
            return nil
        }
        
        self.solutionHTMLString = response["answer_solution"] as? String
        self.markString = response["mark"] as? String

    }

    func convertHTMLStringsToAttributedStrings(){
        self.testQuestionString = LIUtilities.getAttributedStringFromHtmlString(self.testQuestionHTMLString)
        if let solution = self.solutionHTMLString {
           self.solutionString = LIUtilities.getAttributedStringFromHtmlString(solution)
        }
        if let options = self.optionsArray {
            for option in options {
               option.convertHTMLStringsToAttributedStrings()
            }
        }
        
    }
    
}
