//
//  LITestQuestionsDataManager.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 17/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LITestQuestionsDataManager: NSObject {
    static let sharedInstance = LITestQuestionsDataManager()
    var testQuestionsArray:[LITestModel]?
    var totalMark:Int = 0
    var rightAnswerCount:Int = 0
    var wrongAnswerCount:Int = 0
    var skippedQuestionCount:Int = 0
    
    func getNextQuestionAndEndStatusWithCurrentOrder(_ orderNumber:Int, and isAnswered:Bool) -> (LITestModel?,Bool){
        if !isAnswered {
            self.updateSkippedQuestionCount()
        }
        if let testModel = self.testQuestionsArray?.first(where: {$0.orderNumber == orderNumber}) {
            if let index = testQuestionsArray?.index(of: testModel){
                let count = testQuestionsArray?.count ?? 0
                if index < count - 1 {
                    return (testQuestionsArray?[index + 1],false)
                }
            }
        }
        
        return (nil,true)
    }
    
    func updateTotalMarkWith(_ mark:Int?){
        self.totalMark = self.totalMark + (mark ?? 0)
        self.updateRightAnswerCount()
    }
    func updateSkippedQuestionCount(){
        self.skippedQuestionCount += 1
    }
    func updateRightAnswerCount(){
        self.rightAnswerCount += 1
    }
    func updateWrongAnswerCount(){
        self.wrongAnswerCount += 1
    }
    func resetMarks(){
        self.totalMark = 0
        self.rightAnswerCount = 0
        self.wrongAnswerCount = 0
        self.skippedQuestionCount = 0
    }
    
    func updateMarkWithSelectedOption(_ option:LIAnswerOptionModel?, and markString:String?) {
        if let isCorrect = option?.isCorrectOption {
            if isCorrect {
                let mark = Int(markString ?? "0")
                self.updateTotalMarkWith(mark)
            }
            else {
                self.updateWrongAnswerCount()
            }
        }
    }
    
    
}
