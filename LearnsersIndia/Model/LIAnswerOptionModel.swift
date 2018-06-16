//
//  LIAnswerOptionModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIAnswerOptionModel: NSObject {
    var optionId:LIAnswerOptionId?
    var optionHTMLString:String = ""
    var optionString:NSAttributedString?
    var isCorrectOption:Bool = false
    
    override init() {
        super.init()
    }
    convenience init(_ id:LIAnswerOptionId,option:String) {
        self.init()
        self.optionId = id
        self.optionHTMLString = option
//        self.isCorrectOption = isCorrectOption
    }
    func convertHTMLStringsToAttributedStrings(){
        self.optionString = LIUtilities.getAttributedStringFromHtmlString(optionHTMLString)
    }
}
