//
//  LICCAvenueModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 22/07/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LICCAvenueModel: NSObject {

    var accessCode = String()
    var merchantId = String()
    var orderId = String()
    var amount = String()
    var currency = String()
    var redirectUrl = String()
    var cancelUrl = String()
    var rsaKeyUrl = String()
    var rsaKeyDataStr = String()
    var rsaKey = String()
    var encryptedRequest = String()
    var postUrl = String()
    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        guard let accCode = response["access_code"] as? String, let encRequest = response["encRequest"] as? String, let post_url = response["form_url"] as? String
            else {
            return nil
        }
        self.accessCode = accCode
        self.encryptedRequest = encRequest
        self.postUrl = post_url
    }
}
