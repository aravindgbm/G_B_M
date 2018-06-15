//
//  LIProfileItem.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 11/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIProfileItem: NSObject {
    var itemIcon:UIImage?
    var itemTitle:String?
    var profileItemType:LIProfileItemType?
    
    convenience init(_ icon:UIImage?,title:String?,type:LIProfileItemType?) {
        self.init()
        self.itemIcon = icon
        self.itemTitle = title
        self.profileItemType = type
    }
    override init() {
        super.init()
    }
}
