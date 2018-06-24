//
//  LIGameManager.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 23/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIGameManager: NSObject {
    static let sharedInstance = LIGameManager()
    var gameLevelsArray:[LIGameLevelModel]?
    var totalScore:Int = 0
    var isExtraLifeTaken:Bool = false
    var isFiftyFiftyTaken:Bool = false
    func resetValues(){
        self.totalScore = 0
        self.isExtraLifeTaken = false
        self.isFiftyFiftyTaken = false
    }
    
    func getNextLevelWithLevelId(_ levelId:Int) -> (LIGameLevelModel?,Bool){
        //        if !isAnswered {
        //            self.updateSkippedQuestionCount()
        //        }
        if let level = self.gameLevelsArray?.first(where: {$0.levelId == levelId}) {
            if let index = gameLevelsArray?.index(of: level){
                let count = gameLevelsArray?.count ?? 0
                if index < count - 1 {
                    return (gameLevelsArray?[index + 1],false)
                }
            }
        }
        
        return (nil,true)
    }
    func updateTotalScoreWith(_ score:Int){
        self.totalScore += score
    }
    
    func getWrongOptionIndexToBeRemoved(_ options:[LIAnswerOptionModel]?) -> [Int]?{
        let incorrectOptions = options?.filter({$0.isCorrectOption != true})
        if let _ = incorrectOptions {
            var indexArray = [Int]()
            for option in incorrectOptions! {
                if let index = options?.index(of: option) {
                    let count = options?.count ?? 0
                    if index < count {
                        if indexArray.count < 2 {
                            indexArray.append(index)
                        }
                        else {
                            return indexArray
                        }
                    }
                }
            }
        }
        return nil
    }
    func updateScoreWithSelectedOption(_ option:LIAnswerOptionModel?, and levelId:Int?) {
        if let isCorrect = option?.isCorrectOption {
            if isCorrect {
                if let level = self.gameLevelsArray?.first(where: {$0.levelId == levelId}) {
                    self.updateTotalScoreWith(level.levelScore)
                }
            }
        }
    }
    
}