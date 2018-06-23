//
//  LIGameLevelModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 23/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIGameLevelModel: NSObject {

    var levelId:Int?
    var levelName:String?
    var levelScore:Int = 0
    
    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        if let id = response["level_id"] as? Int {
            self.levelId = id
            self.levelName = response["level_name"] as? String
            self.levelScore = response["level_score"] as? Int ?? 0
        }
        else {
              return nil
        }
    }

}
