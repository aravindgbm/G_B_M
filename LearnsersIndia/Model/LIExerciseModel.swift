//
//  LIExerciseModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIExerciseModel: NSObject {
    var exerciseId:Int?
    var exerciseTitle:NSAttributedString?
    var exerciseSolution:NSAttributedString?
    //
    //
    //
    //    chapter_name
    //    boardname
    //    gradename
    //    subjectname
    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        
        if  let htmlExerciseTitle = response["exercise_title"] as? String {
            if let exerciseQuestionText = LIUtilities.getAttributedStringFromHtmlString(htmlExerciseTitle) {
                self.exerciseTitle = exerciseQuestionText
                if let htmlExerciseSolution = response["exercise_solution"] as? String{
                    if let exerciseSolution = LIUtilities.getAttributedStringFromHtmlString(htmlExerciseSolution) {
                         self.exerciseSolution = exerciseSolution
                    }
                    else {
                        return nil
                    }
                }
                else {
                    return nil
                }
                self.exerciseId = response["exercise_id"] as? Int
               
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
}
