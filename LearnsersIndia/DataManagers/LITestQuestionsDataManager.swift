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
    
    func getNextQuestionAndEndStatusWithCurrentOrder(_ orderNumber:Int) -> (LITestModel?,Bool){

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
    
    func updateTotalMarkWith(_ mark:Int){
        self.totalMark = self.totalMark + mark
    }
}
